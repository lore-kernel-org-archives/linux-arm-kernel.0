From: tklauser@distanz.ch (Tobias Klauser)
Date: Tue, 7 Apr 2015 09:49:57 +0200
Subject: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
In-Reply-To: <1428258294.2775.69.camel@perches.com>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Message-ID: <20150407074957.GA25696@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-04-05 at 20:24:54 +0200, Joe Perches <joe@perches.com> wrote:

[...]

>  drivers/tty/serial/altera_jtaguart.c        | 2 +-
>  drivers/tty/serial/altera_uart.c            | 2 +-

For these two drivers:

Acked-by: Tobias Klauser <tklauser@distanz.ch>
