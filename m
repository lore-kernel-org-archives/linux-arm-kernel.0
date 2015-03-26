From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 26 Mar 2015 09:38:58 +0100
Subject: mc34708 regulators
In-Reply-To: <550FE741.9080709@parkeon.com>
References: <550FE741.9080709@parkeon.com>
Message-ID: <73sicsxie5.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Martin,

Martin Fuzzey writes:
> Hi Steffen,
>
> I see you have added the regulator definitions for the mc34708 to the 
> imx53-qsrb device tree.
>
> However there doesn't seem to be a regulator driver for this PMIC in the 
> tree.
>
> mc13xxx supports parts of the functionalities (like the rtc) but only 
> seems to support mc13783 and mc13892 on the regulator side.
>
> Am I missing something?
>

IIRC you are not missing anything. I just took the binding from another
patch and added it to the DT as it was there and didn't look like it
will be any problem later. And (at least) barebox differentiates the QSB
and the QSRB based on the PMIC that is used, because that is the only difference.

> Is there a patch floating around for this?
>

Not that I know of.

Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
