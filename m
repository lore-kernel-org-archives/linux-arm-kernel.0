From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 13:16:25 +0200
Subject: [PATCH 1/5 v2] dmaengine: ste_dma40: Allow memcpy channels to be
 configured from DT
In-Reply-To: <20130501095243.GD25256@gmail.com>
References: <1367336497-10650-1-git-send-email-lee.jones@linaro.org>
 <20130501095243.GD25256@gmail.com>
Message-ID: <CACRpkdZtOtnUYvLm7BPA98oMOLAMPHpJ9GLoyMXOKW1nsTDYiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 1, 2013 at 11:52 AM, Lee Jones <lee.jones@linaro.org> wrote:

> At this moment in time the memcpy channels which can be used by the D40
> are fixed, as each supported platform in Mainline uses the same ones.
> However, platforms do exist which don't follow this convention, so
> these will need to be tailored. Fortunately, these platforms will be DT
> only, so this change has very little impact on platform data.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Real nice!

But can you split this in two patches: one that changes
drivers/dma/ste_dma40* and one sequel patch that changes
Documentation/* and arch/arm/boot/dts/* so I can merge them
out-of-order?

I am trying this development cycle to split changes to the
device trees and bindings off from the rest of the patches
becaused it caused me a mess last cycle.

Yours,
Linus Walleij
