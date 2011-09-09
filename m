From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  9 Sep 2011 15:46:53 +0100
Subject: [RFC PATCH v2 0/3] Per SoC descriptor
Message-ID: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series introduces a per-soc descriptor which should, in the
end, contain most of the SoC specific operations.

This first patch series introduces the arm_soc_desc structure, adds
per-soc SMP and CPU hotplug operations, and converts both RealView and
VExpress to this new scheme.

Should there be a consensus on these patches, I'll convert all the
other SMP platforms.

Patches against next-20110831. Tested on VExpress (A5 and A15) and
RealView EB-11MP.
