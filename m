From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jul 2015 14:45:45 +0100
Subject: [RESEND 08/10] regulator: pwm-regulator: Add support for
 continuous-voltage
In-Reply-To: <20150707133155.GL2887@sirena.org.uk>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
 <1436173112-21397-9-git-send-email-lee.jones@linaro.org>
 <20150707133155.GL2887@sirena.org.uk>
Message-ID: <20150707134545.GH3182@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jul 2015, Mark Brown wrote:

> On Mon, Jul 06, 2015 at 09:58:30AM +0100, Lee Jones wrote:
> 
> > +	tmp = max_duty_cycle - min_mV * max_duty_cycle / vdiff;
> > +	pwm_code = tmp + max_duty_cycle * volt_mV / vdiff;
> 
> These need some brackets to be clear that they're correct.

As you rightly pointed out, this stuff gets over-written in the next
patch, although I have no problem with providing some bracketing if
required.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
