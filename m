From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 3 Apr 2018 09:43:23 +0100
Subject: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Message-ID: <a613f834-f356-a826-526f-aef532f62951@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

On 03/04/18 09:00, Chintan Pandya wrote:
> This series of patches are follow up work (and depends on)
> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> panic in ioremap huge pages".
> 
> This series of patches are tested on 4.9 kernel with Cortex-A75
> based SoC.

Given that this is targeting mainline, can you please test with 4.16?
Basing your patches on something that is over 15 months old is not
exactly reassuring.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
