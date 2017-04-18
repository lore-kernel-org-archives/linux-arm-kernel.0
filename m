From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Apr 2017 07:36:04 +0200
Subject: [PATCH] ARM: sunxi: h3/h5: fix the compatible of R_CCU
In-Reply-To: <20170417103449.31910-1-icenowy@aosc.io>
References: <20170417103449.31910-1-icenowy@aosc.io>
Message-ID: <20170418053604.5nkxjnlnrcepn6x7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 06:34:49PM +0800, Icenowy Zheng wrote:
> The R_CCU of H3/H5 currently wrongly used A64 R_CCU compatible.
> 
> Fix it by changing it to the correct H3 compatible.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/205d4c6a/attachment.sig>
