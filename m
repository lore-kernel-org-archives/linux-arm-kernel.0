From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 Jun 2017 10:32:13 +0200
Subject: [PATCH] ARM: sun6i: a31s: primo81: Enable battery power supply
In-Reply-To: <20170609160549.3566-2-wens@csie.org>
References: <20170609160549.3566-1-wens@csie.org>
 <20170609160549.3566-2-wens@csie.org>
Message-ID: <20170610083213.gsjkd7bzmul33hxy@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 10, 2017 at 12:05:49AM +0800, Chen-Yu Tsai wrote:
> The MSI Primo81 tablet has a 3500 mAh 3.7V LiPo battery.
> 
> Enable the PMIC's battery power supply so the battery can be monitored.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170610/5ab66edf/attachment.sig>
