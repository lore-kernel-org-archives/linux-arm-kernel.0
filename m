From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Apr 2013 11:58:00 +0100
Subject: [PATCH 1/5] ARM: ux500: Move DMA40 platform data includes file
 out to include/
In-Reply-To: <CACRpkdauTuDhEq7H9DPLTGwQsZvpOrcJ62Kk7j6BkLMn8CxqVQ@mail.gmail.com>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdauTuDhEq7H9DPLTGwQsZvpOrcJ62Kk7j6BkLMn8CxqVQ@mail.gmail.com>
Message-ID: <20130415105800.GC6512@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Apr 2013, Linus Walleij wrote:

> On Mon, Apr 8, 2013 at 5:23 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The pin names for DB8500 based platforms need to be moved out of
> 
> "pin names" ???
> 
> > ux500 platform data and into the new proper location in include/
> > linux/platform_data/. This way we an reference them from other
> > external locations, such as the main DMA50 driver(s).
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> (...)
> >  rename arch/arm/mach-ux500/ste-dma40-db8500.h => include/linux/platform_data/dma-ste-dma40-db8500.h (98%)
> 
> Those are the DB8500 DMA channel definitions...
> 
> I will not interfere with the fruitful discussion with Arnd on this
> subject though, I suspect he's right.

It's okay, I've since removed this patch.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
