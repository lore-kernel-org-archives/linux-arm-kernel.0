From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 11 Aug 2014 12:51:37 -0700
Subject: [GIT PULL 2/7] ARM: SoC platform changes for 3.17
In-Reply-To: <1407516479-1251-3-git-send-email-olof@lixom.net>
References: <1407516479-1251-1-git-send-email-olof@lixom.net>
 <1407516479-1251-3-git-send-email-olof@lixom.net>
Message-ID: <20140811195137.GB3711@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ other involved parties

On Fri, Aug 08, 2014 at 09:47:54AM -0700, Olof Johansson wrote:
> This is the bulk of new SoC enablement and other platform changes for 3.17:
[...]
> * Broadcom BCM7xxx settop box chipset is introduced
[...]
> Marc Carino (1):
>       ARM: brcmstb: add infrastructure for ARM-based Broadcom STB SoCs

I realize this is a bit late (the pull request is already merged), but
I'd like to be up-front about this: there were some (late) oustanding
review comments made on this patch [1]. I have a few patches queued
locally for addressing many of them, but not all of the issues are
completely resolved.

Shall I simply send a revert patch for the
arch/arm/mach-bcm/platsmp-brcmstb.c stuff, and get it in through the
bcm -> arm-soc -> Linus merge path in 3.17-rcX? Or should I take the
incremental improvement approach, as we have functioning code with no
clear alternative proposal yet?

Again, sorry for the late noise.

Brian

[1] version 8 patch:

      http://article.gmane.org/gmane.linux.ports.arm.kernel/343391
