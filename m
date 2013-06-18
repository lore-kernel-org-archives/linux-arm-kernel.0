From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 18 Jun 2013 18:58:07 +0100
Subject: [PATCH 3/4] ARM/ARM64: arch_timer: remove __cpuinit attribute
 for arch_counter_set_user_access
In-Reply-To: <1371575223-21702-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1371575223-21702-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <51C09FAF.3050207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/13 18:07, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> We must not declare arch_counter_set_user_access as __cpuinit as we
> need to use it in warm reset paths like CPU PM notifiers.
> 
This patch should be dropped as __cpuinit is removed completely by
http://www.spinics.net/lists/arm-kernel/msg252410.html
Just happen to see it now.

Regards,
Sudeep
