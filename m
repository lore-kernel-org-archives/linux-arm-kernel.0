From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 12:39:40 -0700
Subject: [PATCH 4/4] clocksource: tegra20: use the device_node pointer
 passed to init
In-Reply-To: <1360264144-20714-5-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
 <1360264144-20714-5-git-send-email-robherring2@gmail.com>
Message-ID: <511402FC.50807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 12:09 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> We've already matched the node, so use the node pointer passed in. The rtc
> init was intermingled with the timer init, so split this out to a separate
> init function.

The series,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

Patches 1,4:
Tested-by: Stephen Warren <swarren@nvidia.com>

One thing I wonder re: patch 4 - I know someone (I think Hiroshi, now
CC'd) planned to refactor drivers/clocksource/tegra20_timer.c to enhance
it for Tegra114. I'd like to check with him that the refactoring in this
patch won't impede that at all.
