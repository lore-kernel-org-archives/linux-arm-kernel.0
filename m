From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 25 May 2015 11:27:18 +0200
Subject: [PATCH] backlight: pwm: handle EPROBE_DEFER while requesting
 the PWM
In-Reply-To: <20150312090224.GC3314@x1>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
 <20150312090224.GC3314@x1>
Message-ID: <20150525112718.5f7e2d7d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 12 Mar 2015 09:02:24 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 19 Feb 2015, Nicolas Ferre wrote:
> 
> > When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEFER
> > flag is not handled properly. It can lead to the PWM not being found.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >  drivers/video/backlight/pwm_bl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Applied, thanks.

I don't see this patch in Linus' tree (actually, it's not even in
linux-next).
I don't know where it's stuck, but could you make sure it reaches
mainline for 4.2 (or 4.1 if it's not to late) ?

Best Regards,

Boris




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
