From: vince@simtec.co.uk (Vincent Sanders)
Date: Thu, 22 Jul 2010 12:14:12 +0100
Subject: ARM Kernel autobuilder
Message-ID: <20100722111412.GB10399@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A short note to apologize to the kirkwood people over the autobuilder
producing junk results for their defconfig on the last few builds. The
ccache got corrupted due to a disk glitch. All fixed now.

The current level of 177 Configurations is (to put it mildly)
insane. The 5 year report posted previously explained the
specifics. suffice to say with Linus recent activities anything we can
do to reduce this count is useful.

Can I propose now the omap3_defconfig is working that the duplicate
defconfigs are removed, these are:

cm_t35_defconfig
devkit8000_defconfig
igep0020_defconfig
rx51_defconfig
omap3_beagle_defconfig
omap3_evm_defconfig
am3517_evm_defconfig
omap_4430sdp_defconfig
omap_ldp_defconfig
omap3_pandora_defconfig
omap3_stalker_lks_defconfig
omap_apollon_2420_defconfig
omap_h4_2420_defconfig
omap_2430sdp_defconfig
omap_3430sdp_defconfig
omap_3630sdp_defconfig
omap3_touchbook_defconfig
omap_zoom2_defconfig
omap_zoom3_defconfig
overo_defconfig

This would reduce the default configuration count to 156
configurations. 

There are still a huge number of configurations which support a single
machine which I may look at creating additional combined targets for
futher reducing the build count.

Finally the n8x0 and ns9xxx configurations have failed to build for a
while now.

The n8x0 config supports machines maintained by Kai Svahn, Lauri
Leukkunen and Timo O. Karjalainen can one of you please fix the build?

The ns9xxx configuration has been failing for even longer and teh
machines supported are maintainerd by Uwe Kleine-Konig


-- 
Regards Vincent
http://www.kyllikki.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100722/6bdebb07/attachment.sig>
