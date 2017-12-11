From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sun, 10 Dec 2017 20:24:06 -0600
Subject: [PATCH v2 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <20171201181456.GE8826@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <20171201140406.oanuaz6zvyrhp4ml@lakrids.cambridge.arm.com>
 <20171201175026.GB8826@arm.com>
 <20171201175812.n6ht7h52j3z4pgw2@lakrids.cambridge.arm.com>
 <f86ac529-d763-9f90-1ced-b8a28f545582@linux.intel.com>
 <20171201181456.GE8826@arm.com>
Message-ID: <b02393bf-a372-dd94-8fbe-034e5c8ab93c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Will,

I tested v2 patch series on Centriq2400 server platform successfully, no regression so far. And also
we applied internal patches on top of the branch "kpti" and verified kaiser feature.

Tested-by: Shanker Donthineni <shankerd@codeaurora.org>


-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
