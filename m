From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Jul 2013 13:34:53 -0600
Subject: [PATCH v4 07/17] clocksource: bcm2835: Switch to
 sched_clock_register()
In-Reply-To: <1374189690-10810-8-git-send-email-sboyd@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-8-git-send-email-sboyd@codeaurora.org>
Message-ID: <51E994DD.6010305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2013 05:21 PM, Stephen Boyd wrote:
> The 32 bit sched_clock interface now supports 64 bits. Upgrade to
> the 64 bit function to allow us to remove the 32 bit registration
> interface.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
