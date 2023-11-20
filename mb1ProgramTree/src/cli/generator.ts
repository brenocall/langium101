import type { Model } from '../language/generated/ast.js';
//import * as fs from 'node:fs';
import fs from 'fs';
//import { CompositeGeneratorNode, NL, processGeneratorNode } from 'langium';
import { CompositeGeneratorNode, NL, toString } from 'langium';
import * as path from 'node:path';
import { extractDestinationAndName } from './cli-util.js';

export function replacer(key:any,value:any)
{
    
    console.log("key: "+key);
    console.log("value: "+value);
    /** Every AST node has a type corresponding to what was specified in the grammar declaration. */
    if (key=="$type") return undefined;
    /** The container node in the AST; every node except the root node has a container. */
    else if (key=="$container") return undefined;
    /** The property of the `$container` node that contains this node. This is either a direct reference or an array. */
    else if (key=="$containerProperty") return undefined;
    /** In case `$containerProperty` is an array, the array index is stored here. */
    else if (key=="$containerIndex") return undefined;
    /** The Concrete Syntax Tree (CST) node of the text range from which this node was parsed. */
    else if (key=="$cstNode") return undefined;
    /** The document containing the AST; only the root node has a direct reference to the document. */
    else if (key=="$document") return undefined;
    else return value;
}

export function generateJavaScript(model: Model, filePath: string, destination: string | undefined): string 
{
    const data = extractDestinationAndName(filePath, destination);
    const generatedFilePath = `${path.join(data.destination, data.name)}.json`;

    const fileNode = new CompositeGeneratorNode();

    fileNode.append('"use strict";', NL, NL);
  /*  model.greetings.forEach(greeting => fileNode.append(`console.log('Hello, ${greeting.person.ref?.name}!');`, NL));

    if (!fs.existsSync(data.destination)) {
        fs.mkdirSync(data.destination, { recursive: true });
    }*/

    for (let mB1programTree of model.mb1ProgramTree)
    {
        fileNode.append(`${JSON.stringify(mB1programTree, replacer, 2)}`, NL);
        /*for (let subTable of mB1programTree.subTable)
        {
            fileNode.append(`${JSON.stringify(subTable, replacer, 2)}`, NL);
        }*/
    }

    if (!fs.existsSync(data.destination)) {
        fs.mkdirSync(data.destination, { recursive: true });
    }

   // fs.writeFileSync(generatedFilePath, processGeneratorNode(fileNode));
   // return generatedFilePath;

     fs.writeFileSync(generatedFilePath, toString(fileNode));
     return generatedFilePath;
}
