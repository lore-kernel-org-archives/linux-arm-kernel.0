From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Apr 2016 15:16:13 +0100
Subject: [PATCH v5 03/46] backlight: lm3630a_bl: stop messing with the
 pwm->period field
In-Reply-To: <20160412110809.GI18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110809.GI18882@ulmo.ba.sec>
Message-ID: <20160412141613.GI8094@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 30, 2016 at 10:03:26PM +0200, Boris Brezillon wrote:
> > pwm->period field is not supposed to be changed by PWM users. The only
> > ones authorized to change it are the PWM core and PWM drivers.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/video/backlight/lm3630a_bl.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Applied, thanks.

Applied?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
