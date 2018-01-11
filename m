From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Jan 2018 16:39:28 +0100
Subject: [PATCH] clk: sunxi-ng: defaultly enable DE2 CCU for sun8i/sun50i
In-Reply-To: <20180111030451.9217-1-icenowy@aosc.io>
References: <20180111030451.9217-1-icenowy@aosc.io>
Message-ID: <20180111153928.qys3efun4jjrx4pz@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 11:04:51AM +0800, Icenowy Zheng wrote:
> As DE2 support for more SoCs are introducing, there's many reports that
> the DE2 is not functional due to DE2 CCU code not included in kernel.
> 
> Defaultly enable DE2 CCU for sun8i/sun50i to reduce this kind of
> problems.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

One way to avoid this would have been to add the symbol to the sunxi
and multi_v7 defconfigs...

You're also adding a depends on. This should be explained or at least
mentionned in your commit log.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/4c116c1c/attachment.sig>
