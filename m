From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 09:03:33 +0200
Subject: [PATCH] ARM: dts: sun7i: Fix pll3x2 and pll7x2 not having a
 parent clock
In-Reply-To: <1467144674-21322-1-git-send-email-hdegoede@redhat.com>
References: <1467144674-21322-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160629070333.GA6095@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 10:11:14PM +0200, Hans de Goede wrote:
> Fix pll3x2 and pll7x2 not having a parent clock, specifically this
> fixes the kernel turning of pll3 while simplefb is using it when
> uboot has configured things to use pll3x2 as lcd ch clk parent.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/517e8d41/attachment.sig>
