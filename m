From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 18 Oct 2011 16:27:45 -0700
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
Message-ID: <4E9E0B71.9020708@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm about to submit a set of patches (really pretty small)
to add 4K stack support to ARM (defaulted to 'N').

This has been kicking around in my Sony tree for a few years,
and it's about time to mainline it.  The first patch is
the actual 4KSTACKS patch.  See subsequent patches
for tools to help with stack reduction to avoid the problems
that apparently led to the removal of this feature on x86.

This set includes:
  0001-Add-support-for-4K-kernel-stacks-to-ARM.patch
  0002-Add-static-kernel-function-stack-size-analyzer-for-ARM.patch
  0003-Decrease-poll-and-select-stack-usage-when-using-4K-stacks.patch

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
