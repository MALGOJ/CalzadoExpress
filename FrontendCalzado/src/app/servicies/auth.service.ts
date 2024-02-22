import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import { environment } from '@environments/environment';



@Injectable({
  providedIn: 'root'
})
export class AuthService {

  apiUrl = environment.API_URL;

  constructor(
    private http: HttpClient
  ) { }

  login(email: string, password: string) {
  // Especificamos la ruta donde nos estamos conectado en este caso el login
  return this.http.post(`${this.apiUrl}/api/v1/auth/login` ,{
  
  email,
  password
  } );

  }

}
