From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 6 Aug 2012 15:11:21 +0100
Subject: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C
 driver.
In-Reply-To: <CACRpkdZoJxyZX6SOcAvBP4NBmGyUEiyLH_n_RzSDTBsjS13zug@mail.gmail.com>
References: <1344255947-10062-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZoJxyZX6SOcAvBP4NBmGyUEiyLH_n_RzSDTBsjS13zug@mail.gmail.com>
Message-ID: <20120806141120.GE10524@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 04:00:04PM +0200, Linus Walleij wrote:
> On Mon, Aug 6, 2012 at 2:25 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > At this moment in time there is only one known configuration for the
> > Nomadik I2C driver. By not holding that configuration in the driver
> > adds some unnecessary overhead in platform code. The configuration
> > as already been removed from platform code, this patch checks for any
> > over-riding configurations. If there aren't any, the default is used.
> >
> > Cc: linux-i2c at vger.kernel.org
> > Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This still does not apply for me on v3.6-rc1 what did you base
> this patch on?
> 
> Applying: i2c: Add default configuration into the Nomadik I2C driver.
> error: patch failed: drivers/i2c/busses/i2c-nomadik.c:899
> error: drivers/i2c/busses/i2c-nomadik.c: patch does not apply
> Patch failed at 0001 i2c: Add default configuration into the Nomadik I2C driver.
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".

Ah, my mistake.

I'll rebase to latest and re-submit.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
