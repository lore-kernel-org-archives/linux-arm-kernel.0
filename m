From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 18:45:02 +0200
Subject: [PATCH v3] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <1444256316-2278-1-git-send-email-public_timo.s@silentcreek.de>
References: <1444256316-2278-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <20151011164502.GM2278@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 12:18:36AM +0200, Timo Sigurdsson wrote:
> sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209 PMU
> driver, so add them to allow for voltage-scaling with cpufreq-dt. Also
> add board-specific OPP to use slightly higher voltages at lower
> frequencies since Kevin Hilman reported that not all BananaPi boards run
> stable at the default voltages inherited by sun7i-a20.dtsi.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/b4f848f6/attachment.sig>
