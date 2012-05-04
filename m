From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 4 May 2012 10:28:38 +0800
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
In-Reply-To: <4FA33B7A.3040504@freescale.com>
References: <1335939209-15625-1-git-send-email-b32955@freescale.com>
 <20120502144008.GF2194@S2101-09.ap.freescale.net>
 <1336042485.13013.41.camel@sauron.fi.intel.com>
 <CAAQ0ZWSxNxtF6_1+5NDqR_ry++gKbbNLZHRSTXREG18P+kQL3w@mail.gmail.com>
 <CAMiH66EBO-MHXBb1eB4NMAJo6nPN47_42jYNGUGc=GC7oejPWQ@mail.gmail.com>
 <CAAQ0ZWSqF9x7PSqS_14CscdU+RvcYg8pCFZUqLtDAq8uS_k=yw@mail.gmail.com>
 <4FA33B7A.3040504@freescale.com>
Message-ID: <CAAQ0ZWTPhXNaMyFHyDnB4ez+VYpP=O1z8w-sYQiVspZSDBHuUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 May 2012 10:14, Huang Shijie <b32955@freescale.com> wrote:
> The mxs-dma is another driver (just as the pinctrl driver). I think it's
> better to do the job in parallel.
>
The problem is if the patch gets applied on mtd tree as it is, the
gpmi-nand will stop functioning on mtd tree.  Or you are fine with
that, since no in-tree board support is using the driver so far?  If
you are fine with that, I'm fine too.

Regards,
Shawn
