From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 12 Dec 2013 10:38:31 -0800
Subject: [PATCH] ARM: at91: remove AT91_PROGRAMMABLE_CLOCKS configuration
 option
In-Reply-To: <1386864045-25198-1-git-send-email-nicolas.ferre@atmel.com>
 (Nicolas Ferre's message of "Thu, 12 Dec 2013 17:00:45 +0100")
References: <52A9C81B.7050007@atmel.com>
 <1386864045-25198-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <87sitx6hjs.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> This AT91 specific Kconfig option removed the code that dealt with
> programmable clocks. Each AT91 SoC embeds programmable clocks and
> there is little gain to remove this code in case that such a clock
> is not used.
> If this option is not selected, it causes certain drivers to fail
> to build. We simply remove this option instead of adding code just
> to build a workaround.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Olof, Kevin,
>
> This patch goes on top of the AT91 "cleanup" branch.
>

Applied to next/cleanup.

Thanks,

Kevin
