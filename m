From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Aug 2014 07:47:08 +0100
Subject: [PATCH 0/8] mtd: nand: Support for new DT NAND driver
In-Reply-To: <20140819013110.GO18411@ld-irv-0074>
References: <1407921127-8590-1-git-send-email-lee.jones@linaro.org>
 <20140814224013.GE18411@ld-irv-0074>
 <20140818083953.GA4266@lee--X1>
 <20140819013110.GO18411@ld-irv-0074>
Message-ID: <20140820064708.GC4266@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Aug 2014, Brian Norris wrote:

> On Mon, Aug 18, 2014 at 09:39:53AM +0100, Lee Jones wrote:
> > On Thu, 14 Aug 2014, Brian Norris wrote:
> > > Particularly, take a hard look at rewriting
> > > include/linux/mtd/stm_nand_bbt.h.
> > 
> > I don't think there is any need - although this change is required:
> > 
> > -#if defined(MTD_NAND_STM_BBT)
> > +#if defined(MTD_NAND_STM_BCH_BBT)
> 
> You're still missing a GPL header and #include guards.
> 
> Your whole patch series (both v1 and v2) also has a few legit
> checkpatch.pl warnings. Please fix these.

Will fix all of the above.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
