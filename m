From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 May 2012 22:23:30 +0800
Subject: [PATCH v3] mtd: gpmi: add device tree support for mx6q and mx28
In-Reply-To: <CAMiH66EBO-MHXBb1eB4NMAJo6nPN47_42jYNGUGc=GC7oejPWQ@mail.gmail.com>
References: <1335939209-15625-1-git-send-email-b32955@freescale.com>
 <20120502144008.GF2194@S2101-09.ap.freescale.net>
 <1336042485.13013.41.camel@sauron.fi.intel.com>
 <CAAQ0ZWSxNxtF6_1+5NDqR_ry++gKbbNLZHRSTXREG18P+kQL3w@mail.gmail.com>
 <CAMiH66EBO-MHXBb1eB4NMAJo6nPN47_42jYNGUGc=GC7oejPWQ@mail.gmail.com>
Message-ID: <CAAQ0ZWSqF9x7PSqS_14CscdU+RvcYg8pCFZUqLtDAq8uS_k=yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 May 2012 22:14, Huang Shijie <shijie8@gmail.com> wrote:
> It's better that this patch is merged by l2-mtd, because this patch
> depends on another patch which is
> on the l2-mtd now.
>
But you patch has to be based on mxs-dma DT support to function.
Maybe we should wait for the next merge window?

Regards,
Shawn
