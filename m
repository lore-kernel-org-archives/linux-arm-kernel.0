From: jason77.wang@gmail.com (Hui Wang)
Date: Mon, 21 May 2012 17:45:29 +0800
Subject: [PATCH 0/2] ARM: SMP: Fix cpu hotplug problems
Message-ID: <1337593531-16191-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the RT kernel, current ARM SMP hotplug code will produce two call trace, these two patches can solve call trace problems in the RT kernel, and they are not harmful to standard kernel as well. To consistent between standard kernel and RT kernel, i want to apply these two patches to standard kernel, thus they will be applied to RT kernel automatically in future.

Please kindly to help review these two patches.


Thanks,
Hui.
