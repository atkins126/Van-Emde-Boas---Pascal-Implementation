unit frmMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Spin, TvebArbolUnit;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnCrearArbol: TBitBtn;
    btnDestruirArbol: TBitBtn;
    btnInsertar: TBitBtn;
    btnBuscar: TBitBtn;
    btnEliminar: TBitBtn;
    btnPredecesor: TBitBtn;
    btnSucesor: TBitBtn;
    btnGetMaximo: TBitBtn;
    btnGetMinimo: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    seValor: TSpinEdit;
    txtLog: TMemo;
    Panel1: TPanel;
    seTamanoUniverso: TSpinEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCrearArbolClick(Sender: TObject);
    procedure btnDestruirArbolClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnGetMaximoClick(Sender: TObject);
    procedure btnGetMinimoClick(Sender: TObject);
    procedure btnInsertarClick(Sender: TObject);
    procedure btnPredecesorClick(Sender: TObject);
    procedure btnSucesorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure fnPonerEstadoObjetos(bEstado: Boolean);
    function fnVerificaRango(): Boolean;
    procedure fnAgregarLog(sMensaje: string);
  public

  end;

var
  frmMain: TfrmMain;
  vebArbol: TvebArbol;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  txtLog.Align := alClient;
  fnAgregarLog('write by angel aguilar armendariz');
  fnAgregarLog('arequipa - peru');
end;

procedure TfrmMain.btnCrearArbolClick(Sender: TObject);
begin
  btnCrearArbol.Enabled := False;
  seTamanoUniverso.Enabled := False;

  btnDestruirArbol.Enabled := True;
  fnPonerEstadoObjetos(True);

  vebArbol := TvebArbol.fnCreate(seTamanoUniverso.Value);
  fnAgregarLog('Se creo el arbol');
end;

procedure TfrmMain.btnDestruirArbolClick(Sender: TObject);
begin
  vebArbol.Free();

  btnDestruirArbol.Enabled := False;
  fnPonerEstadoObjetos(False);

  seTamanoUniverso.Enabled := True;
  btnCrearArbol.Enabled := True;
  fnAgregarLog('Se destruyo el arbol');
end;

procedure TfrmMain.fnPonerEstadoObjetos(bEstado: Boolean);
begin
  seValor.Enabled := bEstado;
  btnInsertar.Enabled := bEstado;
  btnBuscar.Enabled := bEstado;
  btnEliminar.Enabled := bEstado;
  btnPredecesor.Enabled := bEstado;
  btnSucesor.Enabled := bEstado;
  btnGetMinimo.Enabled := bEstado;
  btnGetMaximo.Enabled := bEstado;
end;

function TfrmMain.fnVerificaRango(): Boolean;
begin
  if (seValor.Value < seTamanoUniverso.Value) and (seValor.Value > 0) then
    Result := True
  else
  begin
    Application.MessageBox('El valor de X debe ser entre 0 < X < U', 'Error');

    Result := False;
  end;
end;

procedure TfrmMain.fnAgregarLog(sMensaje: string);
begin
  txtLog.Lines.Add(sMensaje);
end;

procedure TfrmMain.btnInsertarClick(Sender: TObject);
begin
  if fnVerificaRango() then
  begin
    vebArbol.fnInsertar(seValor.Value);

    if vebArbol.fnBuscar(seValor.Value) then
      fnAgregarLog('Se inserto el valor: ' + IntToStr(seValor.Value))
    else
      fnAgregarLog('NO se inserto el valor: ' + IntToStr(seValor.Value));

    seValor.SetFocus();
  end;
end;

procedure TfrmMain.btnBuscarClick(Sender: TObject);
begin
  if fnVerificaRango() then
    if vebArbol.fnBuscar(seValor.Value) then
      fnAgregarLog('Se encontro el valor: ' + IntToStr(seValor.Value))
    else
      fnAgregarLog('NO se encontro el valor: ' + IntToStr(seValor.Value));
end;

procedure TfrmMain.btnEliminarClick(Sender: TObject);
begin
  if fnVerificaRango() then
    if vebArbol.fnBuscar(seValor.Value) then
    begin
      vebArbol.fnEliminar(seValor.Value);

      if vebArbol.fnBuscar(seValor.Value) then
        fnAgregarLog('NO se elimino el valor: ' + IntToStr(seValor.Value))
      else
        fnAgregarLog('Se elimino el valor: ' + IntToStr(seValor.Value));
    end
    else
      Application.MessageBox('El valor X no se encuentra en el arbol', 'Error');
end;

procedure TfrmMain.btnPredecesorClick(Sender: TObject);
begin
  if fnVerificaRango() then
    if vebArbol.fnBuscar(seValor.Value) then
      fnAgregarLog( 'El predecesor de: ' + IntToStr(seValor.Value) + ' es: ' + IntToStr( vebArbol.fnPredecesor(seValor.Value) ) )
    else
      Application.MessageBox('El valor X no se encuentra en el arbol', 'Error');
end;

procedure TfrmMain.btnSucesorClick(Sender: TObject);
begin
  if fnVerificaRango() then
    if vebArbol.fnBuscar(seValor.Value) then
      fnAgregarLog( 'El sucesor de: ' + IntToStr(seValor.Value) + ' es: ' + IntToStr( vebArbol.fnSucesor(seValor.Value) ) )
    else
      Application.MessageBox('El valor X no se encuentra en el arbol', 'Error');
end;

procedure TfrmMain.btnGetMinimoClick(Sender: TObject);
var
  iRetorno: Integer;
begin
  iRetorno := vebArbol.fnMinimo();

  if iRetorno = -1 then
    Application.MessageBox('El arbol esta vacio', 'Error')
  else
    fnAgregarLog('Valor Minimo: ' + IntToStr(iRetorno));
end;

procedure TfrmMain.btnGetMaximoClick(Sender: TObject);
var
  iRetorno: Integer;
begin
  iRetorno := vebArbol.fnMaximo();

  if iRetorno = -1 then
    Application.MessageBox('El arbol esta vacio', 'Error')
  else
    fnAgregarLog('Valor Maximo: ' + IntToStr(iRetorno));
end;

end.

