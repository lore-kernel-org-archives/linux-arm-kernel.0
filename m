From: sre@ring0.de (Sebastian Reichel)
Date: Mon, 11 Nov 2013 00:47:17 +0100
Subject: [PATCH] ARM: dts: Add missing reg, interrupt and dma entries for
 omap3
In-Reply-To: <20131017221522.GE15154@atomide.com>
References: <20131017221522.GE15154@atomide.com>
Message-ID: <20131110234717.GA29968@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Oct 17, 2013 at 03:15:22PM -0700, Tony Lindgren wrote:
> Looks like omap3 is still relying on hwmod data for some basic
> device tree information. Let's add the information to omap3.dtsi
> so we can remove the related hwmod data once omap3 is DT only.

This patch fixes a regression in omap3 DT boot introduced by
commit 2a0b965cfb6efc667228831fc3a30308b4f94a87. This commit
assumes, that interrupts are specified via DT data if booted
via DT.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131111/afce4521/attachment.sig>
