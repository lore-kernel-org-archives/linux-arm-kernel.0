From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 7 Feb 2013 21:05:04 +0100
Subject: [PATCH 4/4] clocksource: tegra20: use the device_node pointer
 passed to init
In-Reply-To: <511402FC.50807@wwwdotorg.org>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com><1360264144-20714-5-git-send-email-robherring2@gmail.com><511402FC.50807@wwwdotorg.org>
Message-ID: <20130207.220504.79003148683176035.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> wrote @ Thu, 7 Feb 2013 20:39:40 +0100:

> On 02/07/2013 12:09 PM, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > We've already matched the node, so use the node pointer passed in. The rtc
> > init was intermingled with the timer init, so split this out to a separate
> > init function.
> 
> The series,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> 
> Patches 1,4:
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> One thing I wonder re: patch 4 - I know someone (I think Hiroshi, now
> CC'd) planned to refactor drivers/clocksource/tegra20_timer.c to enhance
> it for Tegra114. I'd like to check with him that the refactoring in this
> patch won't impede that at all.

Actually this covers RTC part. I'll rework mine for the rest on the
top of this.
