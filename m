From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 May 2017 14:47:41 +0200
Subject: [PATCH v3] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <17553199-cc74-96ae-bc75-5e91b866ccd1@rempel-privat.de>
References: <1494048638-24365-1-git-send-email-linux@rempel-privat.de>
 <20170509202725.e2tkry7dmsgx7se5@lukather>
 <17553199-cc74-96ae-bc75-5e91b866ccd1@rempel-privat.de>
Message-ID: <20170510124741.GI5465@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 06:47:58AM +0200, Oleksij Rempel wrote:
> >> +		"", "", "", "", "SCL", "SDA", "", "",
> > 
> > I'm not sure how it's called in the schematics / documentation, but
> > having a way to get which bus it's from would be helpful (like you did
> > for the PMIC I2C bus).
> 
> I use only names provided by schematics. Using something different IMO
> makes no sense and confusing.

Indeed.

> >> +		"", "", "", "", "", "", "", "",
> >> +		/* PC */
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		/* PD */
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		/* PE */
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		/* PF */
> >> +		"SD0-D1", "SD0-D0", "SD0-CLK", "SD0-CMD", "SD0-D3",
> >> +			"SD0-D2", "", "",
> > 
> > Why did you change the wrapping and indentation on those two lines?
> 
> i use 8 entry per line to keep counting easier. If line is too wide, i
> wrap it with changed indentation.

Ack.

> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		/* PG */
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		"", "", "", "", "", "", "", "",
> >> +		/* PH */
> >> +		"TXD0", "RXD0", "IO-1", "PH3", "USB0-IDDET", "PH5", "", "",
> > 
> > What are PH3 and PH5 used for on the board? Can't we provide a more
> > explicit name?
> 
> Only names used by schematic :) If we will use something different users
> will hate us even more.

Those schematics suck then :)

> I can image to use some kind of combination of connector name and pin
> name. For example: "JP1-RXD0", or some thing like this.

There's no mark on the PCB either? RXD0 and the other are fine, the
only ones that concern me are PH3 and PH5, which are basically only
the SoC pin name, and nothing else.

I guess we don't really have the choice if the schematic uses that,
and there's nothing on the PCB..

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170510/beb3fdb2/attachment.sig>
