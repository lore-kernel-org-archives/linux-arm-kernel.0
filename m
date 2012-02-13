From: Hong.Xu@atmel.com (Xu, Hong)
Date: Mon, 13 Feb 2012 17:04:54 +0800
Subject: [PATCH] MTD: atmel_nand: Update driver to support Programmable HW
 ECC controller
In-Reply-To: <20120213084516.GB3378@game.jcrosoft.org>
References: <1329117469-23637-1-git-send-email-hong.xu@atmel.com>
 <20120213084516.GB3378@game.jcrosoft.org>
Message-ID: <4C79549CB6F772498162A641D92D5328045B582C@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi JC,

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: Monday, February 13, 2012 4:45 PM
> To: Xu, Hong
> Cc: dedekind1 at gmail.com; linux-mtd at lists.infradead.org;
dwmw2 at infradead.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] MTD: atmel_nand: Update driver to support
Programmable
> HW ECC controller
> 
> On 15:17 Mon 13 Feb     , Hong Xu wrote:
> > The Programmable Hardware ECC (PMECC) controller is a programmable
binary
> > BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This
controller
> > can be used to support both SLC and MLC NAND Flash devices. It
supports to
> > generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector
of data.
> >
> > To use this driver, the user needs to pass in the correction
capability and
> > the sector size.
> >
> > This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with
JFFS2,
> > YAFFS2, UBIFS and mtd-utils.
> >
> > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> > ---
> this patch must be based on the nand fixes and DT support
> 
> and pass the rom code base via resoruces
> 
> and drop the ifdef

OK no problem. I'll collect other comments, then merge and convert it
with DT support.

BR,
Eric

> Best Regards,
> J.
