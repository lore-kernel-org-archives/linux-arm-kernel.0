From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Mar 2013 16:40:11 -0800
Subject: [PATCH 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <1362614646-24113-4-git-send-email-sboyd@codeaurora.org>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130308004011.GD11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Stephen Boyd <sboyd@codeaurora.org> [130306 17:53]:
> Separate the smp_twd timers from the local timer API. This will
> allow us to remove ARM local timer support in the near future and
> gets us closer to moving this driver to drivers/clocksource.

Looks like applying this patch makes omap4 to stop booting for
some reason.

Regards,

Tony
