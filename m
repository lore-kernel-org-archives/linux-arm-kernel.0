From: per.fransson.ml@gmail.com (Per Fransson)
Date: Fri, 3 Sep 2010 18:17:04 +0000 (UTC)
Subject: [PATCH] ARM: Implement =?utf-8?b?Y3B1X3Y3X3Jlc2V0Lg==?=
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<20100901232307.GC25860@n2100.arm.linux.org.uk>
	<20100902083423.GI25559@gw.healthdatacare.com>
	<20100902084101.GA26319@n2100.arm.linux.org.uk>
	<20100902085341.GJ25559@gw.healthdatacare.com>
	<20100902103957.GR26319@n2100.arm.linux.org.uk>
	<4C7FA6D9.6040307@stericsson.com>
Message-ID: <loom.20100903T200507-728@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Per Fransson <per.xx.fransson <at> stericsson.com> writes:

> 
> 
> I tested the v7 version below and it works fine.
> 
> Regards,
> Per
> 

Oh, no it doesn't, sorry. I must have got my kernel images mixed up. It chokes
on

mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches

/Per
