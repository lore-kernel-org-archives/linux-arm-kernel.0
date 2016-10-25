From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Oct 2016 12:51:35 +0200
Subject: [PATCH] ARM: dts: sun8i: fix the pinmux for UART1
In-Reply-To: <20161024170831.38819-1-icenowy@aosc.xyz>
References: <20161024170831.38819-1-icenowy@aosc.xyz>
Message-ID: <20161025105135.gg6cizedwmbuarqi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 01:08:31AM +0800, Icenowy Zheng wrote:
> When the patch is applied, the allwinner,driver and allwinner,pull
> properties are removed.
> 
> Although they're described to be optional in the devicetree binding,
> without them, the pinmux cannot be initialized, and the uart cannot
> be used.
> 
> Add them back to fix the problem, and makes the bluetooth on iNet D978
> Rev2 board work.
> 
> Fixes: 82eec384249f (ARM: dts: sun8i: add pinmux for UART1 at PG)
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/1babf742/attachment-0001.sig>
