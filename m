From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Aug 2017 16:23:42 +0800
Subject: [PATCH v2 2/2] pwm: add ZTE ZX PWM device driver
In-Reply-To: <20170821060352.GC18996@ulmo>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
 <1501143817-15843-3-git-send-email-shawnguo@kernel.org>
 <20170821060352.GC18996@ulmo>
Message-ID: <20170822082341.GA3685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 08:03:52AM +0200, Thierry Reding wrote:
> On Thu, Jul 27, 2017 at 04:23:37PM +0800, Shawn Guo wrote:
> > From: Shawn Guo <shawn.guo@linaro.org>
> > 
> > It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
> > supports 4 devices with polarity configuration.
> > 
> > The driver has been tested with pwm-regulator support to scale core
> > voltage via cpufreq.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  drivers/pwm/Kconfig  |   9 ++
> >  drivers/pwm/Makefile |   1 +
> >  drivers/pwm/pwm-zx.c | 270 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 280 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-zx.c
> 
> I've applied this, with some bikeshedding applied. See below for the
> changes I made.

Thanks, Thierry.  I appreciate the effort for those changes, and I'm
totally fine with them.

Shawn
