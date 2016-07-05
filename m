From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 10:33:00 +0200
Subject: [PATCH] pinctrl: sunxi: fix nand0 function name for sun8i
In-Reply-To: <20160704022931.46223-1-icenowy@aosc.xyz>
References: <20160704022931.46223-1-icenowy@aosc.xyz>
Message-ID: <20160705083300.GK7643@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2016 at 10:29:31AM +0800, Icenowy Zheng wrote:
> In sun4/5/6/7i, all the pin function related to NAND0 controller is
> named "nand0". However, in sun8i, some of the functions are named as
> "nand". This patch renamed them to "nand0", for the consistency.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/8319f389/attachment.sig>
