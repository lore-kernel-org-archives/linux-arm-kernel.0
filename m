From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 12 Nov 2012 15:49:36 +0100
Subject: [PATCH 05/11] ARM: at91: convert timer suspend/resume to
 clock_event_device
In-Reply-To: <1352408516-21988-7-git-send-email-swarren@wwwdotorg.org>
References: <1352408516-21988-1-git-send-email-swarren@wwwdotorg.org>
 <1352408516-21988-7-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121112144936.GL4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:01 Thu 08 Nov     , Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Move at91's timer suspend/resume functions from struct sys_timer
> at91sam926x_timer into struct clock_event_device pit_clkevt. This
> will allow the sys_timer suspend/resume fields to be removed, and
> eventually lead to a complete removal of struct sys_timer.
> 
> Cc: Andrew Victor <linux@maxim.org.za>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
look fine

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
