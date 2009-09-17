From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 17 Sep 2009 12:04:59 +0200
Subject: [PATCH V2 0/3] at91_can: add support for Atmel's CAN controller
	on AT91SAM9263
In-Reply-To: <4AB20679.2040602@grandegger.com>
References: <1253180254-11910-1-git-send-email-mkl@pengutronix.de>
	<4AB20679.2040602@grandegger.com>
Message-ID: <4AB209CB.10707@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wolfgang Grandegger wrote:
>> This patch series adds support for the Atmel CAN controller as found
>> on the AT91SAM9263.
>>
>> It adds the at91_can to the generic device definition, activates the CAN
>> controller on the at91sam9263ek and adds the driver itself.
>>
>> Changes since V1:
>> - let Kconfig depend on CAN_DEV
>> - add example how driver is used in baord file
>>
>> Please review and consider for inclusion.
> 
> A Vx patch suffix would be nice next time.

Sorry, missed that. I was in a hurry, because they wanted to reboot the
server....

>> cheers, Marc
>>
>> Marc Kleine-Budde (3):
>>       at91sam9263: add at91_can device to generic device definition
>>       at91sam9263ek: activate at91 CAN controller
>>       at91_can: add driver for Atmel's CAN controller on AT91SAM9263
> 
> I have just added my "signed-off-by" for the Socket-CAN patch #3. Don't
> known who will take care of the other patches.

Thanks Wolfgang.

Andrew, are the first two going throught the arm tree?

cheers, Marc

- --
Pengutronix e.K.                         | Marc Kleine-Budde           |
Linux Solutions for Science and Industry | Phone: +49-231-2826-924     |
Vertretung West/Dortmund                 | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686         | http://www.pengutronix.de   |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqyCMwACgkQjTAFq1RaXHP/bACfbWSs52bkNoPICUMTufN8lA4v
yqIAoI0VIrCZKEHja/XEOLHum51zpJ4V
=dn2a
-----END PGP SIGNATURE-----
