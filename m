From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Mar 2017 08:24:35 +0100
Subject: [PATCH] spi: sun6i: update max transfer size reported
In-Reply-To: <20170320143849.13213-1-icenowy@aosc.xyz>
References: <20170320143849.13213-1-icenowy@aosc.xyz>
Message-ID: <20170321072435.vmr3p77vh5af2ysh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 10:38:49PM +0800, Icenowy Zheng wrote:
> The spi-sun6i driver have already got the ability to do large transfers.
> However, the max transfer size reported is still fifo depth - 1.
> 
> Update the max transfer size reported to the max value possible.
> 
> Reported-by: Martin Ayotte <martinayotte@gmail.com>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/2ca9c79b/attachment.sig>
