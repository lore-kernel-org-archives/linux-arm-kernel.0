From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 20 Jun 2017 11:26:08 +0200
Subject: [PATCH] arm: aspeed: Add Aspeed board file with clocksource
 devicetree fixup
In-Reply-To: <CACRpkdYqoa0+h6FkP_aJL=DTGysOFZVke0Sf-MCuT81y-zH3AQ@mail.gmail.com>
References: <CAK8P3a0EaqwmAMRWn--29e4Kt6zJA9kHL2dpj=7Uabn5hANxOA@mail.gmail.com>
 <20170609073037.21871-1-andrew@aj.id.au>
 <CAK8P3a23XpDQhnM=j8FBS8NGck2ZfaAotVo191NEOttP2GDCYA@mail.gmail.com>
 <1497012772.23335.12.camel@aj.id.au>
 <CACRpkdYqoa0+h6FkP_aJL=DTGysOFZVke0Sf-MCuT81y-zH3AQ@mail.gmail.com>
Message-ID: <CACmBeS26EEgGX8bOAPxVscCjLXM_fHaY=8_guACPDVsH5ii8KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 June 2017 at 10:06, Linus Walleij <linus.walleij@linaro.org> wrote:
> Moxart is deploying the DTBs with the kernel, they go hand-in-hand.
> Backward compatibility with old DTBs here would just be an academic
> exercise.

I've used CONFIG_ARM_APPENDED_DTB=y since the beginning mainly because
UC-7112-LX's proprietary bootloader lacks DTB capabilities (that I'm
aware of).
Compiling both (kernel and dtb) at the same time always made sense to
me, and it does, even when the hardware has a sane bootloader (i.e.
DTB enabled).


   Jonas
