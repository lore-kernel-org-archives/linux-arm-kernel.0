From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Apr 2016 15:16:53 +0100
Subject: [PATCH v5 02/46] backlight: pwm_bl: remove useless call to
 pwm_set_period()
In-Reply-To: <20160412110350.GH18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-3-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110350.GH18882@ulmo.ba.sec>
Message-ID: <20160412141653.GJ8094@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 30, 2016 at 10:03:25PM +0200, Boris Brezillon wrote:
> > The PWM period will be set when calling pwm_config. Remove this useless
> > call to pwm_set_period(), which might mess up with the internal PWM state.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Applied, thanks.

Applied?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
