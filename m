From: robert.richter@amd.com (Robert Richter)
Date: Wed, 29 Sep 2010 16:52:25 +0200
Subject: [PATCH] oprofile, arm: proper release resources on failure
Message-ID: <20100929145225.GJ13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

the patch below fixes a resource leak I found during code review. Can
you please review and test it (I don't have an ARM environment for
this available). If you are fine with the change, please ack. I want
to send it upstream via tip/perf/urgent.

Though you reworked the code already, parts of the fix are still valid
for latest oprofile code in oprofile/core.

Ingo,

if Will agrees with it, please apply it directly to tip/perf/urgent.

Thanks,

-Robert

--
