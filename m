From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 4 Apr 2012 08:39:56 +0200
Subject: [PATCH v5 01/16] pwm: Add PWM framework support
In-Reply-To: <20120404063605.GB7264@S2101-09.ap.freescale.net>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-2-git-send-email-thierry.reding@avionic-design.de>
 <20120404063605.GB7264@S2101-09.ap.freescale.net>
Message-ID: <20120404063956.GA17478@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shawn Guo wrote:
> A couple of trivial editorial errors, otherwise,
> 
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> 
> On Wed, Mar 28, 2012 at 04:33:43PM +0200, Thierry Reding wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > This patch adds framework support for PWM (pulse width modulation) devices.
> > 
> > The is a barebone PWM API already in the kernel under include/linux/pwm.h,
> 
> s/The/There
> 
> > but it does not allow for multiple drivers as each of them implements the
> > pwm_*() functions.
> > 
> ...
> 
> > +/**
> > + * pwm_request() - request a PWM device
> > + * @pwm: global PWM device index
> 
> s/pwm/pwm_id
> 
> > + * @label: PWM device label
> > + */
> > +struct pwm_device *pwm_request(int pwm_id, const char *label)
> ...
> 
> > +/**
> > + * struct pwm_chip - abstract a PWM
> > + * @label: for diagnostics
> > + * @owner: helps prevent removal of modules exporting active PWMs
> 
> The doc needs an update.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120404/590c1526/attachment-0001.sig>
