From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 31 Aug 2012 16:45:06 +0200
Subject: [PATCH 03/10] serial: atmel: add explict mach/gpio.h include
In-Reply-To: <504028CC.9020202@gmail.com>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-4-git-send-email-robherring2@gmail.com>
 <20120829233705.GT18957@n2100.arm.linux.org.uk>
 <504028CC.9020202@gmail.com>
Message-ID: <20120831144506.GD23867@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:00 Thu 30 Aug     , Rob Herring wrote:
> On 08/29/2012 06:37 PM, Russell King - ARM Linux wrote:
> > On Wed, Aug 29, 2012 at 05:31:29PM -0500, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> In preparation to remove implicit inclusion of mach/gpio.h, add explicit
> >> include of mach/gpio.h.
> > 
> > Definitely NAK.
> > 
> > What is in the Atmel mach/gpio.h has hardly anything to do with the
> > gpio subsystem (it's more a private gpio implementation).  It should
> > be renamed as such to make it clear (and so it doesn't trigger my
> > sanity filtering.)
> 
> Jean-Christophe, Does your gpio clean-up address this?
yes I've a patch series on my local tree that cleanup this

on at91 we do not need the include/mach/gpio.h

and I do plan to drop most of the stuff in it

Best Regards,
J.
