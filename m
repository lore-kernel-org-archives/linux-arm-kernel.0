From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Feb 2015 15:15:44 +0100
Subject: [PATCH v3 04/10] phy: Add driver to support individual USB PHYs
 on sun9i
In-Reply-To: <1422388455-25923-5-git-send-email-wens@csie.org>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
 <1422388455-25923-5-git-send-email-wens@csie.org>
Message-ID: <20150201141544.GE4827@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 03:54:09AM +0800, Chen-Yu Tsai wrote:
> Unlike previous Allwinner SoCs, there is no central PHY control block
> on the A80. Also, OTG support is completely split off into a different
> controller.
> 
> This adds a new driver to support the regular USB PHYs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150201/4ce61023/attachment-0001.sig>
