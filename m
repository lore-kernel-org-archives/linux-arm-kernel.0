From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 7 Apr 2014 10:21:02 +1000
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20140407102102.97ad7dcaab69324efa8d897a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/boot/dts/qcom-msm8960.dtsi, arch/arm/boot/dts/qcom-msm8974.dtsi,
arch/arm/mach-omap2/pdata-quirks.c, arch/arm/mach-zynq/Kconfig,
drivers/watchdog/Kconfig and sound/soc/kirkwood/Kconfig between various
merge commits from Linus' tree and various merge commits from the arm-soc
tree.

I used the versions from Linus' tree.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/31b71923/attachment.sig>
