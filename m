From: marex@denx.de (Marek Vasut)
Date: Sat, 11 Aug 2012 14:47:17 +0200
Subject: [PATCH v3] mtd: gpmi: add NAND write verify support
In-Reply-To: <CAMiH66GbOYDpo-RDUct2nCixaf+9vhmT8Ouz+YPx95Z1+g2B1Q@mail.gmail.com>
References: <1344700231-12624-1-git-send-email-shijie8@gmail.com>
 <201208110913.54479.marex@denx.de>
 <CAMiH66GbOYDpo-RDUct2nCixaf+9vhmT8Ouz+YPx95Z1+g2B1Q@mail.gmail.com>
Message-ID: <201208111447.18076.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> On Sat, Aug 11, 2012 at 3:13 PM, Marek Vasut <marex@denx.de> wrote:
> > Dear Huang Shijie,
> > 
> > Please re-add credit to Fabio. Also, Fabio fixed the subject to be more
> 
> sorry. Should I add "Reported by : Fabio ...." to the patch?

Yes, at least.

> I really appriaciate Fabio's work, but I do not think Fabio's patch is
> more accurate.
> The nand chips can be 2K page, 4K page and 8K page. But most of the
> time, the nand chip is 4K page.
> If we fix the verify_buf to 8K size as Fabio's patch does. It will
> waste much memory.
> This is my concern now. :)

That's all right, but the rest of your patch is Fabio's work, correct me if I'm 
wrong. Just give the guy some credit, he found the flaw and diag'd it.

> My patch maybe not good. So If Fabio also sends out a new patch which
> allocates the verify_buf with the mtd->writesize size.
> I will ack it.

Either way is OK.

[...]

> > Best regards,
> > Marek Vasut
