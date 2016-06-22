From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Jun 2016 11:52:03 +0200
Subject: [PATCH 4.7 fix] ARM: dts: sunxi: Add pll3 to simplefb nodes
 clocks lists
In-Reply-To: <1466456242-22841-1-git-send-email-hdegoede@redhat.com>
References: <1466456242-22841-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160622095203.GT26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 10:57:22PM +0200, Hans de Goede wrote:
> Now that we've a clock node describing pll3 we must add it to the
> simplefb nodes clocks lists to avoid it getting turned off when
> simplefb is used.
> 
> This fixes the screen going black when using simplefb.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/68cec676/attachment-0001.sig>
