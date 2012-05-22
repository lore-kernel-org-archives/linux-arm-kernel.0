From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 08:34:25 +0200
Subject: [PATCH V2] GPMI-NAND: Define ecc.strength
In-Reply-To: <1337668383.2483.87.camel@sauron.fi.intel.com>
References: <1337633967-8387-1-git-send-email-marex@denx.de>
 <1337668383.2483.87.camel@sauron.fi.intel.com>
Message-ID: <201205220834.25981.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Artem Bityutskiy,

> On Mon, 2012-05-21 at 22:59 +0200, Marek Vasut wrote:
> > The ecc.strength wasn't set, resulting in the following crash:
> > [    2.550000] kernel BUG at drivers/mtd/nand/nand_base.c:3347!
> > [    2.550000] Internal error: Oops - BUG: 0 [#1] ARM
> 
> Pushed to l2-mtd.git, thanks!

Thank you!

Best regards,
Marek Vasut
