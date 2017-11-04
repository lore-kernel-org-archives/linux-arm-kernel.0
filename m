From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sat, 04 Nov 2017 17:44:50 +0100
Subject: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
In-Reply-To: <20171104131352.GA9271@kroah.com>
References: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de>
 <20171104131352.GA9271@kroah.com>
Message-ID: <59FDEE82.4040204@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Le 04/11/2017 14:13, Greg Kroah-Hartman a ?crit :
> On Sat, Nov 04, 2017 at 02:00:00PM +0100, V10lator wrote:
>> Devices like DCF77 receivers need the baud-rate to be as low as 50.
>>
>> I have tested this on a Meson GXL device with uart_A.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.com>
>> Cc: Carlo Caione <carlo@caione.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: linux-amlogic at lists.infradead.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Thomas Rohloff <v10lator@myway.de>
>> ---
>> drivers/tty/serial/meson_uart.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What changed from v2?
> 
> And I need a real name as the author of the patch :(
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

Hi Thomas,

Make sure the "From" header of your mail matches the Signed-off-by tag, overwise use the --from option with "git send-email" to be sure, or generate the patch with the "git format-patch" with the "--from" option.

Anyway :
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
