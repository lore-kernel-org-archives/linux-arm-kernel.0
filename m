From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 21 Sep 2009 13:41:12 +0200
Subject: [PATCH] at91: at91sam9g45 family: identify several chip versions
In-Reply-To: <1253529601-15474-1-git-send-email-nicolas.ferre@atmel.com>
References: <1253529601-15474-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20090921114112.GR29905@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:40 Mon 21 Sep     , Nicolas Ferre wrote:
> cpu_is_xxx() macros are identifying generic at91sam9g45 chip. This patch adds
> the capacity to differentiate Engineering Samples and final lots through the
> inclusion of  at91_cpu_fully_identify() and the related chip IDs with chip
> version field preserved.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/include/mach/cpu.h     |    9 +++++++++
>  arch/avr32/mach-at32ap/include/mach/cpu.h |    1 +
>  2 files changed, 10 insertions(+), 0 deletions(-)
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
