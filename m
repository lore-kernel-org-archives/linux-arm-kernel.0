From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Aug 2014 19:52:53 +0200
Subject: [PATCH] ARM: dt: sunxi: Remove i2c controller clock-frequency
 that matches default
In-Reply-To: <1408383945-27940-1-git-send-email-wens@csie.org>
References: <1408383945-27940-1-git-send-email-wens@csie.org>
Message-ID: <20140818175253.GF15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 01:45:45AM +0800, Chen-Yu Tsai wrote:
> The clock-frequency values of the i2c controller nodes match the
> defaults of the driver. Remove the properties to use the defaults,
> and be consistent with sun8i.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Merged, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/191d34f7/attachment.sig>
