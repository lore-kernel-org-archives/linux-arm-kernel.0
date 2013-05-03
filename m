From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 3 May 2013 12:57:39 +0100
Subject: [PATCH 1/5 v2] dmaengine: ste_dma40: Allow memcpy channels to be
 configured from DT
In-Reply-To: <CACRpkdZtOtnUYvLm7BPA98oMOLAMPHpJ9GLoyMXOKW1nsTDYiQ@mail.gmail.com>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
 <20130501095243.GD25256@gmail.com>
 <CACRpkdZtOtnUYvLm7BPA98oMOLAMPHpJ9GLoyMXOKW1nsTDYiQ@mail.gmail.com>
Message-ID: <20130503115739.GJ24153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 May 2013, Linus Walleij wrote:

> On Wed, May 1, 2013 at 11:52 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > At this moment in time the memcpy channels which can be used by the D40
> > are fixed, as each supported platform in Mainline uses the same ones.
> > However, platforms do exist which don't follow this convention, so
> > these will need to be tailored. Fortunately, these platforms will be DT
> > only, so this change has very little impact on platform data.
> >
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Per Forlin <per.forlin@stericsson.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Real nice!
> 
> But can you split this in two patches: one that changes
> drivers/dma/ste_dma40* and one sequel patch that changes
> Documentation/* and arch/arm/boot/dts/* so I can merge them
> out-of-order?
> 
> I am trying this development cycle to split changes to the
> device trees and bindings off from the rest of the patches
> becaused it caused me a mess last cycle.

I was under the impression that the documentation went with the
bindings, rather than the Device Tree. Am I wrong?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
