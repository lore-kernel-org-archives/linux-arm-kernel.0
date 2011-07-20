From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 20 Jul 2011 08:19:34 +0300
Subject: [i.MX28 GPMI] problem overwriting all-0xff data in NAND
In-Reply-To: <1311139000.20738.146.camel@sauron>
References: <20004.12663.29494.339601@ipc1.ka-ro>
	<20110718164354.GA3328@S2100-06.ap.freescale.net>
	<4E24E804.10002@freescale.com> <1311139000.20738.146.camel@sauron>
Message-ID: <1311139179.20738.149.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-07-20 at 08:16 +0300, Artem Bityutskiy wrote:
> This is a different issue. You refer to the "GPMI-controlled flash has
> no space in OOB for JFFS2". Lothar's issue is about "GPMI-controlled
> flash does not allow writing 0xFFs and then writing something else",
> which is very normal.

Huang, to be more precise, I think Lothar's issue is the same as
described here:
http://www.linux-mtd.infradead.org/doc/ubi.html#L_flasher_algo

Although the description is about UBI and UBIFS - this is applicable
for JFFS2 as well.

-- 
Best Regards,
Artem Bityutskiy
