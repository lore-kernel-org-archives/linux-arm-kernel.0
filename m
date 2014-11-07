From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 07 Nov 2014 11:25:14 -0800
Subject: [PATCH v4 2/3] PM / clock_ops: make __pm_clk_enable more generic
In-Reply-To: <1415281862-23764-3-git-send-email-grygorii.strashko@ti.com>
 (Grygorii Strashko's message of "Thu, 6 Nov 2014 15:51:01 +0200")
References: <1415281862-23764-1-git-send-email-grygorii.strashko@ti.com>
 <1415281862-23764-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <7h1tpestid.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grygorii Strashko <grygorii.strashko@ti.com> writes:

> Now there are two places in code which do the same things,
> so allow __pm_clk_enable() to accept pointer on pm_clock_entry
> structure as second parameter instead of pointer on clock and
> remove duplicated code.
>
> Also, updated function intended to be used by following patch.
>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Kevin Hilman <khilman@linaro.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Kevin Hilman <khilman@linaro.org>
