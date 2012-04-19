From: Hong.Xu@atmel.com (Xu, Hong)
Date: Thu, 19 Apr 2012 06:40:19 +0000
Subject: [PATCH] MTD: AT91: Update atmel_nand_data to support PMECC
In-Reply-To: <20120419061500.GR16641@game.jcrosoft.org>
References: <1334802819-30428-1-git-send-email-hong.xu@atmel.com>
 <20120419061500.GR16641@game.jcrosoft.org>
Message-ID: <A92DB5DF46DBC241980A99BFD8A00AEE0F62C7F9@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: Thursday, April 19, 2012 2:15 PM
> To: Xu, Hong
> Cc: Ferre, Nicolas; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] MTD: AT91: Update atmel_nand_data to support PMECC
> 
> On 10:33 Thu 19 Apr     , Hong Xu wrote:
> > Added two items,
> > * correction_cap: PMECC correction capability
> > * sector_size:    Sector size for PMECC
> >
> > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> > ---
> where is the driver?

Mtd/master is on v3.3-rc6(by today) which does not include your changes about platform-data/atmel.h
So I planed to update platform data through AT91 tree and then post the driver to MTD mentioning the platform data commit in AT91 (I hoped to avoid the syncing issues between MTD tree and AT91/ARM SoC tree)

BR,
Eric
> 
> Best Regards,
> J.
