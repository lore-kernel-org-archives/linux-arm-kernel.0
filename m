From: b32955@freescale.com (Huang Shijie)
Date: Fri, 4 May 2012 10:39:07 +0800
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
In-Reply-To: <CAAQ0ZWTPhXNaMyFHyDnB4ez+VYpP=O1z8w-sYQiVspZSDBHuUw@mail.gmail.com>
References: <1335939209-15625-1-git-send-email-b32955@freescale.com>	<20120502144008.GF2194@S2101-09.ap.freescale.net>	<1336042485.13013.41.camel@sauron.fi.intel.com>	<CAAQ0ZWSxNxtF6_1+5NDqR_ry++gKbbNLZHRSTXREG18P+kQL3w@mail.gmail.com>	<CAMiH66EBO-MHXBb1eB4NMAJo6nPN47_42jYNGUGc=GC7oejPWQ@mail.gmail.com>	<CAAQ0ZWSqF9x7PSqS_14CscdU+RvcYg8pCFZUqLtDAq8uS_k=yw@mail.gmail.com>	<4FA33B7A.3040504@freescale.com>
 <CAAQ0ZWTPhXNaMyFHyDnB4ez+VYpP=O1z8w-sYQiVspZSDBHuUw@mail.gmail.com>
Message-ID: <4FA3414B.3050302@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?05?04? 10:28, Shawn Guo ??:
> On 4 May 2012 10:14, Huang Shijie<b32955@freescale.com>  wrote:
>> The mxs-dma is another driver (just as the pinctrl driver). I think it's
>> better to do the job in parallel.
>>
> The problem is if the patch gets applied on mtd tree as it is, the
> gpmi-nand will stop functioning on mtd tree.  Or you are fine with
even this patch is get applied. the gpmi-nand still can not work. I still
have to add the pinctl patch to it. So it have no difference on whether 
the mxs-dma driver is ready or not. :)
So let it go in parallel.

Best Regards
Huang Shijie


> that, since no in-tree board support is using the driver so far?  If
> you are fine with that, I'm fine too.
>
> Regards,
> Shawn
>
