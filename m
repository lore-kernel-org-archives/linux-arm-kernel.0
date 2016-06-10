From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jun 2016 15:36:27 +0100
Subject: [PATCH v3 10/20] pwm: sysfs: Add PWM Capture support
In-Reply-To: <20160610140404.GL27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-11-lee.jones@linaro.org>
 <20160610140404.GL27142@ulmo.ba.sec>
Message-ID: <20160610143627.GD1537@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Wed, Jun 08, 2016 at 10:21:25AM +0100, Lee Jones wrote:
> > Allow a user to read PWM Capture results from /sysfs.
> > 
> > To start a capture and read the result, simply read the file:
> > 
> >   $ cat $PWMCHIP/capture
> > 
> > The output format is "<period>:<duty_cycle>".
> 
> The format below is "<period> <duty cycle>".
> 
> No need to rev the series for this, I can take patches 8 and 10 as-is
> and make those modifications myself.

Ideal, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
