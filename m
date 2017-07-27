From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 27 Jul 2017 16:26:51 +0800
Subject: [PATCH 2/2] pwm: add ZTE ZX PWM device driver
In-Reply-To: <20170725115343.GD22355@ulmo>
References: <1498704874-14599-1-git-send-email-shawnguo@kernel.org>
 <1498704874-14599-3-git-send-email-shawnguo@kernel.org>
 <20170725115343.GD22355@ulmo>
Message-ID: <20170727082649.GJ29754@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 01:53:43PM +0200, Thierry Reding wrote:
> On Thu, Jun 29, 2017 at 10:54:34AM +0800, Shawn Guo wrote:
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
> >  drivers/pwm/pwm-zx.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-zx.c
> 
> Hi Shawn,
> 
> This is close to perfect. Two minor things, see below.

Hi Thierry,

Thanks for helping review the patch.  I just send out v2 to address
your comments.

Shawn
