From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 May 2015 11:22:50 +0200
Subject: [PATCH 03/12] clocksource: sti: Provide 'use timer as sched
 clock' capability
In-Reply-To: <55506CB0.2030909@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
 <1431078730.13593.14.camel@x220> <20150508102938.GD29044@x1>
 <1431085625.13593.39.camel@x220> <55506CB0.2030909@linaro.org>
Message-ID: <1431336170.2398.73.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-11 at 10:47 +0200, Daniel Lezcano wrote:
> The general policy is to have non-prompted options in the clocksource's 
> Kconfig and let the platform's config to select the right components.

If you want to stick to that policy here there's no reason to add
CLKSRC_ST_LPC_TIMER_SCHED_CLOCK in this patch. It currently adds
nothing, as it will always be equal to whatever value CLKSRC_ST_LPC will
have, right?


Paul Bolle
