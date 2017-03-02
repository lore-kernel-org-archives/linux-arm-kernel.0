From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 14:55:27 +0100
Subject: [PATCH v6 1/4] clk: sunxi-ng: add Allwinner H5 CCU support for
 H3 CCU driver
In-Reply-To: <20170301201342.47583-2-icenowy@aosc.xyz>
References: <20170301201342.47583-1-icenowy@aosc.xyz>
 <20170301201342.47583-2-icenowy@aosc.xyz>
Message-ID: <20170302135527.sgu2cipqmnadpxgj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 04:13:39AM +0800, Icenowy Zheng wrote:
> Allwinner H5 is a SoC that features a design which keeps the peripheral
> compatible with H3, so that it have also a CCU like the one on H3 --
> only one bus gate/reset is added, and the mmc sample/output phases are
> removed because of MMC controller update.
> 
> Add its support in our existing H3 CCU driver.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/96cc8a9e/attachment.sig>
