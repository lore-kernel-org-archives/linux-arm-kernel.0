From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Aug 2016 08:47:55 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: fix uart1 CTS/RTS pins at PG on
 A23/A33
In-Reply-To: <20160823055826.20591-1-icenowy@aosc.xyz>
References: <20160823055826.20591-1-icenowy@aosc.xyz>
Message-ID: <20160823064755.GA2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 23, 2016 at 01:58:25PM +0800, Icenowy Zheng wrote:
> PG8, PG9 is said to be the CTS/RTS pins for UART1 according to the A23/33
> datasheets. However, the function is wrongly named "uart2" in the pinctrl
> driver. This patch fixes this by modifying them to be named "uart1".
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

This looks good, but could you send it to stable?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/f03c83a4/attachment.sig>
