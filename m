From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 2 Mar 2012 17:17:49 +0200
Subject: [PATCHv4 0/6] ARM: OMAP3+: IO daisychain support fixes
Message-ID: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Changes compared to previous version:

- patch2:
 * changed timeout value to 100us (from 1000)
 * added poll for the IO status == 0 at the end of trigger sequence
- patch4:
 * omap3: global wakeup done in PRM init instead of OMAP3 PM init
 * omap4: moved global wakeup enable from trigger func to PRM init

Tested on omap3beagle / omap4blaze, suspend / resume works with io chain.

-Tero
