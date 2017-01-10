From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 19:10:06 +0100
Subject: [PATCH 2/5] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170103151629.19447-3-icenowy@aosc.xyz>
References: <20170103151629.19447-1-icenowy@aosc.xyz>
 <20170103151629.19447-3-icenowy@aosc.xyz>
Message-ID: <20170110181006.yrd6moy2mctzoc4c@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 11:16:26PM +0800, Icenowy Zheng wrote:
> V3s has a similar but cut-down CCU to H3.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

It looks like there's nothing different but the clocks that you
register with the H3, please just use the H3 driver.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/8a227678/attachment-0001.sig>
