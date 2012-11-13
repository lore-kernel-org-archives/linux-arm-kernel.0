From: chuansheng.liu@intel.com (Liu, Chuansheng)
Date: Tue, 13 Nov 2012 08:00:21 +0000
Subject: [PATCH 1/7] I2c-nomadik: Fix the usage of
 wait_for_completion_timeout
In-Reply-To: <20121113075813.GA23119@pengutronix.de>
References: <1352222317.15558.1584.camel@cliu38-desktop-build>
 <20121112172651.GC15159@pengutronix.de>
 <27240C0AC20F114CBF8149A2696CBE4A1C3952@SHSMSX101.ccr.corp.intel.com>
 <20121113075813.GA23119@pengutronix.de>
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A1C3EE6@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Tuesday, November 13, 2012 3:58 PM
> To: Liu, Chuansheng
> Cc: linus.walleij at linaro.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; linux-i2c at vger.kernel.org
> Subject: Re: [PATCH 1/7] I2c-nomadik: Fix the usage of
> wait_for_completion_timeout
> 
> 
> > Thanks your pointing out. I just manually reviewed the code when found
> > this point. Would like to try some auto-script but failed:)
> 
> I can suggest 'coccinelle' for that kind of job.
Thanks, let me try, if possible anyone can give some help?
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
