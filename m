From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 4 Nov 2017 14:13:52 +0100
Subject: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
In-Reply-To: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de>
References: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de>
Message-ID: <20171104131352.GA9271@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 04, 2017 at 02:00:00PM +0100, V10lator wrote:
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

What changed from v2?

And I need a real name as the author of the patch :(
