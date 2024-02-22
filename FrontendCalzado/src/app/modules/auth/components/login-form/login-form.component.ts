import { Component } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { faPen, faEye, faEyeSlash } from '@fortawesome/free-solid-svg-icons';

// IMPORTAMOS EL SERVICIO 
import { AuthService } from 'src/app/servicies/auth.service'; 

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html'
})
export class LoginFormComponent {

  form = this.formBuilder.group({
    email: ['', [Validators.email, Validators.required]],
    password: ['', [Validators.required, Validators.minLength(6)]],
  });

  faPen = faPen;
  faEye = faEye;
  faEyeSlash = faEyeSlash;
  showPassword = false;
  status: string = 'init';

  constructor(
    private formBuilder: FormBuilder,
    private router: Router,
    private authService: AuthService
  ) { }

  doLogin() {
    if (this.form.valid) {
      this.status = 'loading';
      const { email, password } = this.form.getRawValue();
      // Verificar si tanto el email como la contraseña no son null antes de enviarlos al servicio
      if (email !== null && password !== null) {
        this.authService.login(email, password).subscribe(
          (response) => {
            this.status = 'success';
            // Manejar respuesta exitosa, por ejemplo, redireccionar al usuario a otra página.
            this.router.navigate(['/app']);
          },
          (error) => {
            // Manejar error, por ejemplo, mostrar un mensaje de error al usuario.
            this.status = 'error';
            this.status = 'failed';
          }
        );
      }
    } else {
      // Marcar todos los campos del formulario como tocados para mostrar los mensajes de error.
      this.form.markAllAsTouched();
    }
  }
}
