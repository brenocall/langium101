import type { ValidationChecks } from 'langium';
import type { Mb1ProgramTreeAstType } from './generated/ast.js';
import type { Mb1ProgramTreeServices } from './mb-1-program-tree-module.js';

/**
 * Register custom validation checks.
 */
export function registerValidationChecks(services: Mb1ProgramTreeServices) {
    const registry = services.validation.ValidationRegistry;
    const validator = services.validation.Mb1ProgramTreeValidator;
    const checks: ValidationChecks<Mb1ProgramTreeAstType> = {
        //Person: validator.checkPersonStartsWithCapital
    };
    registry.register(checks, validator);
}

/**
 * Implementation of custom validations.
 */
export class Mb1ProgramTreeValidator {

    // checkPersonStartsWithCapital(person: Person, accept: ValidationAcceptor): void {
    //     if (person.name) {
    //         const firstChar = person.name.substring(0, 1);
    //         if (firstChar.toUpperCase() !== firstChar) {
    //             accept('warning', 'Person name should start with a capital.', { node: person, property: 'name' });
    //         }
    //     }
    // }

}
