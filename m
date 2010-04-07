From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 7 Apr 2010 16:45:54 -0700
Subject: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
In-Reply-To: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, back online now.

On Wed, Apr 7, 2010 at 4:12 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This is the fifth iteration of this ever growing patch set
> for PrimeCell DMA support, reposting the entire series.
>
> This now depend on stuff pending in Dan Williams async_tx
> (DMA Devices/Engine) tree and Andrew Mortons tree where
> the new DMA40 driver for U8500 is queued.
>
> I suggest putting these into Andrews tree now, since:
>
> A) 4 of the patches it touches MMCI code which is hanled
> ? by Andrew
>

Ok, but it looks like they do not have a build dependency on dma bits
so they could be merged separately i.e. on top of the async_tx branch.

> B) It extends the DMA40 driver which is now pending in
> ? his tree as well.
>
> C) Since there doesn't seem to be any consensus of whether
> ? this is the right way forward, it needs some wider
> ? testing I believe.

No consensus with respect to which pieces, the Primecell driver or
something outside of drivers/dma?  Forgive me for missing recent
conversations if this has been discussed to death already.

> OK?

I can go ahead and queue up the dma bits unless you would prefer, and
Andrew agrees, to take this all through the -mm tree?

--
Dan
