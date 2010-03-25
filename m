From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 25 Mar 2010 23:08:51 +0300
Subject: [PATCH 0/4] Support for Cavium Networks CNS3xxx machines
Message-ID: <20100325200851.GA6470@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These patches add support for machines with ECONA CNS3xxx ARM11
MPcore (ARMv6) dual-core processors. Note that this is very basic
support, there is no support for SMP or fancy peripheral devices
as found in CNS3xxx SOCs (though, as shown in patches 3/4 and 4/4
we'll add these features soon).

Patches 1/4 and 2/4 have no external dependencies except for
mach-types update.

Patches 3/4 and 4/4 are a bit trickier. Patch 3/4 depends on a few
sdhci updates that are in -mm tree, and patch 4/4 depends on some
ahci rework that is in libata-dev tree ('next' branch).

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
