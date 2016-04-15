From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Apr 2016 13:39:41 +0100
Subject: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
In-Reply-To: <20160412102926.GC18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
Message-ID: <20160415123941.GD3589@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> [...]
> > +struct sti_cpt_data {
> > +	u32 snapshot[3];
> > +	int index;
> > +	int gpio;
> 
> On a side-note, this should probably use struct gpio_desc * instead of
> an integer along with the gpiod_*() APIs for the GPIO handling.

Why would you need to do that?

of_get_named_gpio() does all that for you.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
