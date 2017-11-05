From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 5 Nov 2017 15:12:06 +0100
Subject: [PATCH v4] tty: serial: meson: allow baud-rates lower than 9600
In-Reply-To: <bb0a70cc-6cc1-46d2-aa04-046a37c9f516@myway.de>
References: <bb0a70cc-6cc1-46d2-aa04-046a37c9f516@myway.de>
Message-ID: <20171105141206.GA31306@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 05, 2017 at 05:29:30AM +0100, Thomas Rohloff wrote:
> Devices like DCF77 receivers need the baud-rate to be as low as 50.
> 
> I have tested this on a Meson GXL device with uart_A.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Thomas Rohloff <v10lator@myway.de>
> ---
> drivers/tty/serial/meson_uart.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c
> b/drivers/tty/serial/meson_uart.c
> index 07c0f98be3ac..e281ce5d101d 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -362,7 +362,7 @@ static void meson_uart_set_termios(struct uart_port
> *port,

This is line-wrapped and can not be applied :(

It's your email client, look at this setting:
	Content-Type: text/plain; charset=utf-8; format=flowed

format=flowed does not work for kernel patches, it corruptes and edits
them as it thinks this is just a conversation, not a machine-readable
format.

5th try?  :)

thanks,

greg k-h
