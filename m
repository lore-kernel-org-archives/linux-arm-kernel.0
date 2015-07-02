From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 2 Jul 2015 11:10:31 +0800
Subject: [RFC] arm: psci: implement cpuidle_ops
Message-ID: <20150702111031.05f04184@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

we'd like to use cpuidle-arm.c for both arm and arm64 with psci as backend. For
arm64, it works. But for arm, we miss cpuidle_ops. I want to add cpuidle_ops for
arm psci, I dunno whether this is the correct direction, could you please give
suggestions?

Thanks,
Jisheng
