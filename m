From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Jun 2016 12:14:42 +0100
Subject: [PATCH v3 08/20] pwm: Add PWM Capture support
In-Reply-To: <20160610163956.GA8696@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-9-lee.jones@linaro.org>
 <20160610135302.GK27142@ulmo.ba.sec> <20160610143854.GE1537@dell>
 <20160610163956.GA8696@ulmo.ba.sec>
Message-ID: <20160620111442.GA4490@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Fri, Jun 10, 2016 at 03:38:54PM +0100, Lee Jones wrote:
> > On Fri, 10 Jun 2016, Thierry Reding wrote:
> > 
> > > On Wed, Jun 08, 2016 at 10:21:23AM +0100, Lee Jones wrote:
> > > > Supply a PWM Capture call-back Op in order to pass back
> > > > information obtained by running analysis on PWM a signal.
> > > > This would normally (at least during testing) be called from
> > > > the Sysfs routines with a view to printing out PWM Capture
> > > > data which has been encoded into a string.
> > > > 
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
> > > >  include/linux/pwm.h | 25 +++++++++++++++++++++++++
> > > >  2 files changed, 52 insertions(+)
> > 
> > So do you want me to re-spin?
> > 
> > Before you said you'd make adjustments on patches 8 through 10, so I'm
> > a little confused.
> 
> Yeah, I only realized that it might be quicker to make these adjustments
> myself when I had finished looking at patch 10. I've pushed the adjusted
> patches to a for-4.8/pwm-capture branch, so if you're going to re-spin
> the remainder of the patches, perhaps that could be your base?
> 
> 	https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-4.8/pwm-capture
> 
> If you don't have any objections I can put those into linux-next early
> next week.

That's fine by me.  I will rebase.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
