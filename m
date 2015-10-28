From: drew.richardson@arm.com (Drew Richardson)
Date: Wed, 28 Oct 2015 08:07:59 -0700
Subject: [PATCH v6 0/2] arm: perf: Add event descriptions
Message-ID: <20151028150758.GA12239@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another spin of the arm32 version of adding the event
descriptors, this time without the weird copy of attr_groups in
armpmu_init which was there last time [0]. This depends on Marks fix
[1].

GIT: [PATCH 1/2] arm: perf: Convert event enums to #defines
GIT: [PATCH 2/2] arm: perf: Add event descriptions

[0] https://lkml.org/lkml/2015/10/13/544
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/381480.html
