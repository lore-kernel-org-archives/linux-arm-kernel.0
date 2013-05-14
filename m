From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 May 2013 09:45:37 +0100
Subject: [PATCH 3/9] clk: ux500: Provide device enumeration number suffix
 for SMSC911x
In-Reply-To: <CACRpkdaWaEct1My5=gZ7Bbbizqsr3BBNSXiahMn3bS7L-SubLg@mail.gmail.com>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-4-git-send-email-lee.jones@linaro.org>
 <CACRpkdaWaEct1My5=gZ7Bbbizqsr3BBNSXiahMn3bS7L-SubLg@mail.gmail.com>
Message-ID: <20130514084537.GD3297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > First Ethernet device has a ".0" appended onto the device name. It
> > appears that we need this in order to obtain the correct clock.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Post -rc1 poke for Mike.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
