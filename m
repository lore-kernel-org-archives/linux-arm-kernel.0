From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Jun 2013 10:11:29 +0100
Subject: [PATCH 3/9] clk: ux500: Provide device enumeration number suffix
 for SMSC911x
In-Reply-To: <20130610090837.GC20297@gmail.com>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-4-git-send-email-lee.jones@linaro.org>
 <CACRpkdaWaEct1My5=gZ7Bbbizqsr3BBNSXiahMn3bS7L-SubLg@mail.gmail.com>
 <20130610090837.GC20297@gmail.com>
Message-ID: <20130610091129.GD20297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Lee Jones wrote:

> Hi Mike,
> 
> > > First Ethernet device has a ".0" appended onto the device name. It
> > > appears that we need this in order to obtain the correct clock.
> > >
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It appears this one slipped through the gaps.

Ah, I'm telling lies of course.

It _is_ in -next. Thanks Mike.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
