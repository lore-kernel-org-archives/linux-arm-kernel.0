From: marex@denx.de (Marek Vasut)
Date: Thu, 24 May 2012 23:27:31 +0200
Subject: [PATCH V2] GPMI-NAND: Define ecc.strength
In-Reply-To: <4FBE57DB.400@newsguy.com>
References: <1337633967-8387-1-git-send-email-marex@denx.de>
 <201205220834.25981.marex@denx.de> <4FBE57DB.400@newsguy.com>
Message-ID: <201205242327.31910.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Dunn,

> On 05/21/2012 11:34 PM, Marek Vasut wrote:
> > Dear Artem Bityutskiy,
> > 
> >> On Mon, 2012-05-21 at 22:59 +0200, Marek Vasut wrote:
> >>> The ecc.strength wasn't set, resulting in the following crash:
> >>> [    2.550000] kernel BUG at drivers/mtd/nand/nand_base.c:3347!
> >>> [    2.550000] Internal error: Oops - BUG: 0 [#1] ARM
> >> 
> >> Pushed to l2-mtd.git, thanks!
> > 
> > Thank you!
> 
> Yes, thanks much Marek.  I must have missed this one while doing the
> EUCLEAN patches (maybe because it's in its own directory).  Sorry to
> everyone for the confusion it caused.

Mike, nice to see you became more involved with the MTD :-) How's the DoCG3/G4 
thing turned out btw?

> Mike

Best regards,
Marek Vasut
