From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Feb 2016 19:31:13 +0100
Subject: [PATCH v2] ARM: sunxi_defconfig: Enable MUSB HDRC driver with
 Allwinner glue
In-Reply-To: <1455031887-14147-1-git-send-email-wens@csie.org>
References: <1455031887-14147-1-git-send-email-wens@csie.org>
Message-ID: <20160209183113.GV31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 11:31:27PM +0800, Chen-Yu Tsai wrote:
> Allwinner SoCs typically have a Mentor Graphics Inventra MUSB dual role
> controller for USB OTG.
> 
> Now that the issue with MUSB and USB gadget registration order has been
> resolved, we can enable this driver in dual role mode. This requires the
> NOP USB transceiver driver, which is also enabled.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/71e9bf9b/attachment.sig>
