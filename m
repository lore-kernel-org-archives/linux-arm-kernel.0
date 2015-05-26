From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 May 2015 08:36:48 +0100
Subject: [NEXT REQUEST][PATCH] backlight: pwm: handle EPROBE_DEFER while
 requesting the PWM
In-Reply-To: <20150525112718.5f7e2d7d@bbrezillon>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
 <20150312090224.GC3314@x1> <20150525112718.5f7e2d7d@bbrezillon>
Message-ID: <20150526073648.GB11677@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen, Boris,

> > > When trying to request the PWM device with devm_pwm_get(), the EPROBE_DEFER
> > > flag is not handled properly. It can lead to the PWM not being found.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > 
> > Applied, thanks.
> 
> I don't see this patch in Linus' tree (actually, it's not even in
> linux-next).
> I don't know where it's stuck, but could you make sure it reaches
> mainline for 4.2 (or 4.1 if it's not to late) ?

Sorry for the confusion.

It looks like my for-backlight-fixes branch isn't in -next.

Stephen, could you rectify that please?

M: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
