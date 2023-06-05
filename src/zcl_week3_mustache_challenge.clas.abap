CLASS zcl_week3_mustache_challenge DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:
      BEGIN OF ty_jogos,
        jogo   TYPE string,
        valor  TYPE string,
        status TYPE string,
      END OF ty_jogos .
    TYPES:
      tt_jogos TYPE STANDARD TABLE OF ty_jogos WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_console,
        console TYPE string,
        dados   TYPE tt_jogos,
      END OF ty_console .
    TYPES:
      tt_lista_jogos TYPE STANDARD TABLE OF ty_console WITH DEFAULT KEY .

    CONSTANTS:
      BEGIN OF c_status,
        encomenda TYPE string VALUE 'Encomenda',
        estoque   TYPE string VALUE 'Em estoque',
        falta     TYPE string VALUE 'Em falta',
      END OF c_status .
    CONSTANTS newline TYPE abap_char1 VALUE cl_abap_char_utilities=>newline ##NO_TEXT.
protected section.
private section.
ENDCLASS.



CLASS ZCL_WEEK3_MUSTACHE_CHALLENGE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lt_lista_jogos) = VALUE tt_lista_jogos(
       ( console = 'Playstation 5' dados = VALUE tt_jogos(
                                                      (  jogo = 'God of War Ragnarok' valor = 'R$300,00' status = c_status-estoque )
                                                      (  jogo = 'Spider-Man 2' valor = 'R$350,00' status = c_status-encomenda )
                                                      (  jogo = 'The Last of Us Part II' valor = 'R$250,00' status = c_status-estoque )
                                                     )
       )
       ( console = 'Nintendo Switch' dados = VALUE tt_jogos(
                                                      (  jogo = 'Zelda Tears of the Kingdom' valor = 'R$400,00' status = c_status-falta )
                                                      (  jogo = 'Mario Odyssey' valor = 'R$300,00' status = c_status-estoque )
                                                      (  jogo = 'Xenoblade Chronicles 3' valor = 'R$300,00' status = c_status-encomenda )
                                                     )
       )
       ( console = 'Xbox Series S/X' dados = VALUE tt_jogos(
                                                      (  jogo = 'Hallo Inifite' valor = 'R$200,00' status = c_status-estoque )
                                                      (  jogo = 'Forza Horizon 5' valor = 'R$300,00' status = c_status-estoque )
                                                      (  jogo = 'Fable 4' valor = 'R$300,00' status = c_status-encomenda )
                                                     )
       )
       ( console = 'Super Nintendo' dados = VALUE tt_jogos(
                                                      (  jogo = 'Super Mario World' valor = 'R$400,00' status = c_status-estoque )
                                                      (  jogo = 'Sunset Riders' valor = 'R$500,00' status = c_status-encomenda )
                                                      (  jogo = 'International Superstar Soccer Deluxe' valor = 'R$250,00' status = c_status-estoque )
                                                     )
       )

                                         ).

    TRY.
        DATA(lo_mustache) = zcl_mustache=>create(
                                'Lista de jogos por console!' && newline && newline &&
                                '{{console}}:'  && newline &&
                                '{{#dados}}'    && newline &&
                                '>>> Jogo: {{jogo}} - Valor: {{valor}} - Status: {{status}}' && newline &&
                                '{{/dados}}'
                            ).

        out->write( lo_mustache->render( lt_lista_jogos ) ).
      CATCH zcx_mustache_error.
        "handle exception
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
