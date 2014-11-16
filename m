From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 17:56:49 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add de_be0 clk parent pll to
 simplefb node
In-Reply-To: <1416154172-4116-1-git-send-email-hdegoede@redhat.com>
References: <1416154172-4116-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141116165649.GI6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 05:09:32PM +0100, Hans de Goede wrote:
> Avoid the parent pll for the mod-clk for de_be0 getting disabled when non of
> the other users are enabled (which can happen when none of i2c, spi and mmc
> are in use).
> 
> Note for now we point directly to the parent rather then to the de_be0 mod-clk
> as that is not modelled in our devicetree yet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/b0a82eef/attachment-0001.sig>
