From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 29 Aug 2018 11:14:46 +0200
Subject: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
 socfpga_cyclone5_de0_nano_soc.dts
In-Reply-To: <fd0f01e5-41a2-6a24-2ce4-482b30b348b6@denx.de>
References: <fd0f01e5-41a2-6a24-2ce4-482b30b348b6@denx.de>
Message-ID: <73bm9lwn3t.fsf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Marek Vasut <marex@denx.de> writes:

> Hi,
>
> I was recently experimenting with the DE0 Nano SoC / Atlas SoC . 
> I had a
> hard time finding the right DT for the board, but then was 
> suggested
> that the DT for the board is socfpga_cyclone5_de0_sockit.dts . 
> This did
> not make sense to me, since SoCKit is a different board 
> altogether. But
> the DTS seems to be indeed for the DE0 Nano SoC.
>
> To fix up this confusion, I'd propose renaming of the
> socfpga_cyclone5_de0_sockit.dts to 
> socfpga_cyclone5_de0_nano_soc.dts to
> match the label on the package .
>
> What do you think ?

Ack. This confusion came up multiple times. The barebox-specific 
dts "overlay"
is already named socfpga_cyclone5_de0_nano_soc.dts because of 
this.


Regards,
Steffen


-- 
Pengutronix e.K.                          | Steffen Trumtrar 
|
Industrial Linux Solutions                | 
http://www.pengutronix.de/ |
Peiner Str. 6-8, 31137 Hildesheim, Germany| Phone: 
+49-5121-206917-0   |
Amtsgericht Hildesheim, HRA 2686          | Fax: 
+49-5121-206917-5555|
