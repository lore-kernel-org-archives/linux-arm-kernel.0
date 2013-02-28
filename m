From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Feb 2013 14:17:05 +0000
Subject: [PATCH 3/7] ARM: hs: add board support with device tree
In-Reply-To: <CAD6h2NR2e0_MogO+PxGS8BrDT8OqzehrRzC-zoyvzjdk8vdLUw@mail.gmail.com>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
 <201302281104.13885.arnd@arndb.de>
 <CAD6h2NR2e0_MogO+PxGS8BrDT8OqzehrRzC-zoyvzjdk8vdLUw@mail.gmail.com>
Message-ID: <201302281417.05177.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 February 2013, Haojian Zhuang wrote:
> >
> > This looks right at the moment, but I also have a patch to make it possible to drop the
> > irqchip_init, clocksource_of_init and hs_init() calls here, as they are all the
> > defaults. At that point, the platform would be essentially empty except for the
> > debug_ll_io_init part that is inherently platform specific.
> >
> >         Arnd
> 
> Could you give me the link of your patch? I could rebase this patch.

I only posted an RFC so far, at

https://patchwork.kernel.org/patch/2074871/

It's probably easier for now if you ignore it. We will see how to stage
things after the merge window, once we are putting both your patch and
mine into arm-soc.

	Arnd
