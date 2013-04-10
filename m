From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 10 Apr 2013 17:17:43 +1000
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
Message-ID: <20130410171743.2ffa67388b330991228a6775@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-s3c24xx/Kconfig between commit 785f40040874 ("cpufreq:
s3c24xx: move cpufreq driver to drivers/cpufreq") from the pm tree and
commits fb278af74b28 ("ARM: S3C24XX: Removed unneeded dependency on
CPU_S3C2410") and a4e4d22c6f53 ("ARM: S3C24XX: Removed unneeded
dependency on CPU_S3C2412") from the arm-soc tree.

I fixed it up by removing the sections from arch/arm/mach-s3c24xx/Kconfig
and can carry thefix as necessary (no action is required).

P.S. those arm-soc tree commits have a bad Author email address ...
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130410/0accd4a6/attachment.sig>
