From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Oct 2017 11:09:51 +0200
Subject: [PATCH] ARM: sun8i: r40: add watchdog device node
In-Reply-To: <20171013112621.18932-1-icenowy@aosc.io>
References: <20171013112621.18932-1-icenowy@aosc.io>
Message-ID: <20171016090950.jqz5ekfwhjqvsxtm@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 07:26:21PM +0800, Icenowy Zheng wrote:
> The R40 SoC has a watchdog like the one on A20, in the timer memory zone
> (which is also the same on A20).
> 
> Add the device tree node for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171016/c85216b9/attachment.sig>
