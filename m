From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 1 May 2010 17:48:01 -0700
Subject: [PATCH 3/3] DMAENGINE: add PrimeCell generic DMA to PL022 v6
In-Reply-To: <1271481165-9848-1-git-send-email-linus.walleij@stericsson.com>
References: <1271481165-9848-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <h2te9c3a7c21005011748r234216a2o35c5a979e9e7f0ca@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 10:12 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This extends the PL022 SSP/SPI driver with generic DMA engine
> support using the PrimeCell DMA engine interface. Also fix up the
> test code for the U300 platform.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> Changes from v5:
> - Rebased on async_tx tree instead

I just back-merged 2.6.34-rc4 into async-tx to pick up the
gfp.h/slab.h conversion... prior to reading this patch.  Can I just
use v5?

--
Dan
