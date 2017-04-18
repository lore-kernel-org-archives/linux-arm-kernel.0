From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Apr 2017 07:35:22 +0200
Subject: [PATCH] arm64: dts: allwinner: pine64: Add remaining UART aliases
In-Reply-To: <20170414190804.21865-1-afaerber@suse.de>
References: <20170414190804.21865-1-afaerber@suse.de>
Message-ID: <20170418053522.ebkimevucq57y2km@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 09:08:04PM +0200, Andreas F?rber wrote:
> Enabling uart2 node currently leads to a /dev/ttyS1 device, with ttyS0..4
> always present, causing confusion on the user's part.
> 
> dtc cannot resolve an overlay's &uart2 reference for strings, only for
> phandles, so it would need to hardcode the full node path.
> 
> Avoid this and enforce reliable numbering by adding serialX aliases for:
> 
> UART1 - on Wifi/BT connector
> UART2 - on Pi-2 connector
> UART3 - on Euler connector
> UART4 - on Euler connector
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

Applied, thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/c26970a1/attachment.sig>
