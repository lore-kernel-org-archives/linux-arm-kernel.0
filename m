From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 10 Sep 2014 14:18:50 +1000
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
Message-ID: <20140910141850.34c07f72@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Today's linux-next merge of the pm tree got a conflict in
arch/arm/mach-shmobile/setup-sh73a0.c between commit aa0bdc303b0f
("ARM: shmobile: sh73a0: Remove duplicate CPUFreq bits") from the
arm-soc tree and commit 978027e170fb ("cpufreq: cpu0: rename driver and
internals to 'cpufreq_dt'") from the pm tree.

I fixed it up (the former removed the lines that were updated by the
latter) and can carry the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/992b659e/attachment.sig>
