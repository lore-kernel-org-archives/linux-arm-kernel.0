From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Aug 2017 11:48:16 +0200
Subject: [PATCH] arm64: allwinner: a64: pine64: Use dcdc1 regulator for
 mmc0
In-Reply-To: <1502516402-4661-1-git-send-email-jteki@openedev.com>
References: <1502516402-4661-1-git-send-email-jteki@openedev.com>
Message-ID: <20170821094816.wqygjbchdlguezlo@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 11:10:02AM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Since current tree support AXP803 regulators, replace
> fixed regulator with AXP803 dcdc1 regulator.
> 
> Tested on pine64.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/c75ab151/attachment.sig>
