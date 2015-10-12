From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Oct 2015 11:27:30 +0200
Subject: [PATCH v2 2/5] ARM: dts: sunxi: Add dtsi for AXP22x PMIC
In-Reply-To: <1444488540-11263-3-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
 <1444488540-11263-3-git-send-email-wens@csie.org>
Message-ID: <20151012092730.GY2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 10:48:57PM +0800, Chen-Yu Tsai wrote:
> The AXP22x family of PMIC is used with some Allwinner SoCs. This
> includes the AXP221, AXP221s and AXP223. They differ in the host
> interface, maximum supply current for DCDC1 regulator, and default
> voltage and state for various LDO regulators. Also, the AXP221s
> does not support fine calibration of the battery fuel gauge.
> 
> This patch adds a dtsi file for all the common bindings for these
> PMICs. Currently this is just listing all the regulator nodes. The
> regulators are initialized based on their device node names.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/2797d1d1/attachment.sig>
