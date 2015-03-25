From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 17:28:27 +0000
Subject: [patch v11 17/23] clocksource / arch_timer: Parse GTDT to
 initialize arch timer
In-Reply-To: <1427205776-5060-18-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-18-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150325172827.GM14585@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:50PM +0800, Hanjun Guo wrote:
> Using the information presented by GTDT (Generic Timer Description Table)
> to initialize the arch timer (not memory-mapped).
> 
> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
