From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 19 Jun 2012 08:16:06 +0200
Subject: [PATCH] leds: Add DT support for leds-pca9532
In-Reply-To: <4FDE1BCF.60109@wwwdotorg.org>
References: <1339855851-9171-1-git-send-email-stigge@antcom.de>
 <4FDCA0FC.5000409@wwwdotorg.org> <4FDDC4A9.1040706@antcom.de>
 <4FDE1BCF.60109@wwwdotorg.org>
Message-ID: <20120619061606.GA32193@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 12:02:55PM -0600, Stephen Warren wrote:
> On 06/17/2012 05:51 AM, Roland Stigge wrote:
> > Hi,
> > 
> > On 16/06/12 17:06, Stephen Warren wrote:
> >>> +- nxp,typecodes: groups of 2 bits for each of the 16 pins:
> >>> +  0: None
> >>> +  1: LED
> >>> +  2: Beep
> >>> +  3: GPIO
> >>> +- nxp,statecodes: groups of 2 bits for each of the 16 pins:
> >>> +  0: off
> >>> +  1: on
> >>> +  2: pwm0
> >>> +  3: pwm1
> >>> +
> >>> +Optional properties:
> >>> +- nxp,psc: array of 2 numbers: PSC values for the two PWM channels (see datasheet)
> >>> +- nxp,pwm: array of 2 numbers: PWM values for the two PWM channels (see datasheet)
> >>
> >> Shouldn't that all be exposed using a combination of the pinctrl
> >> bindings that are in 3.5, and the PWM bindings that should be coming in 3.6?
> > 
> > Thanks for the note! I found a pwm tree that should have this at
> > 
> > http://gitorious.org/linux-pwm/linux-pwm
> > 
> > but it gives me server errors. Is there a place where I can have a look?
> 
> That URL (with http:// replace with git://) did work for me. It seemed a
> little slow at first, but did work without issue. I Cc'd Thierry in case
> there's any other location available.

There isn't. IIRC, back when I finalized the PWM subsystem during the last
cycle, Arnd Bergmann suggested that I request an account and repository on
kernel.org back when the subsystem was ready. At the time I didn't think
it necessary, but reading this, perhaps it wouldn't be such a bad idea.
kernel.org should have better availability than gitorious.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120619/f2625929/attachment.sig>
