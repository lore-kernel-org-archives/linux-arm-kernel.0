From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 23 Sep 2009 00:07:58 +0200
Subject: [PATCH V2 0/3] at91_can: add support for Atmel's CAN controller
	on AT91SAM9263
In-Reply-To: <cd73a99e0909211431k37429a70o4efaac7104f7d526@mail.gmail.com>
References: <1253180254-11910-1-git-send-email-mkl@pengutronix.de>	
	<4AB20679.2040602@grandegger.com> <4AB209CB.10707@pengutronix.de>
	<cd73a99e0909211431k37429a70o4efaac7104f7d526@mail.gmail.com>
Message-ID: <4AB94ABE.6070409@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey Andrew,

Andrew Victor wrote:
>>>> Marc Kleine-Budde (3):
>>>>       at91sam9263: add at91_can device to generic device definition
>>>>       at91sam9263ek: activate at91 CAN controller
>>>>       at91_can: add driver for Atmel's CAN controller on AT91SAM9263
>>> I have just added my "signed-off-by" for the Socket-CAN patch #3. Don't
>>> known who will take care of the other patches.
>> Thanks Wolfgang.
>>
>> Andrew, are the first two going throught the arm tree?
> 
> That would be best.
> Please submit them to Russell King's patch system.

done as:

5722	at91sam9263: add at91_can device to generic device definition
5723	at91sam9263ek: activate at91 CAN controller

Cheers, Marc

- --
Pengutronix e.K.                         | Marc Kleine-Budde           |
Linux Solutions for Science and Industry | Phone: +49-231-2826-924     |
Vertretung West/Dortmund                 | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686         | http://www.pengutronix.de   |
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkq5Sr4ACgkQjTAFq1RaXHNrLgCfeVy7xmi1UzdxGeWK3z4XRqMC
rjYAn2EK0LKhOe/S890W2bq6ElzPDNQL
=phat
-----END PGP SIGNATURE-----
