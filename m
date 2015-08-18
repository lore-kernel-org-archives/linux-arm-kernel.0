From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Aug 2015 17:36:31 +0200
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <20150818153631.GH2547@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 02, 2015 at 06:18:25PM +0200, Timo Sigurdsson wrote:
> sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209 PMU
> driver, so add them to allow for voltage-scaling with cpufreq-dt.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

Queued, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150818/0b35cc74/attachment.sig>
