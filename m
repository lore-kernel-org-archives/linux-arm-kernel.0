From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Oct 2011 18:35:46 +0100
Subject: [PATCH v4 00/10] Per SoC descriptor
Message-ID: <1317663356-5114-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduces a per-soc descriptor which should, in the
end, contain most of the SoC specific operations.

This first patch series introduces the arm_soc_desc structure, adds
per-soc SMP and CPU hotplug operations, and converts all SMP platform
to this new scheme.

Patches against next-20110930. Tested on VExpress (A5 and A15),
RealView EB-11MP, OMAP4 (Panda) and Tegra2 (Harmony).

Changelog:
