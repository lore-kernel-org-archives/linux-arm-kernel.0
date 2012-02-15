From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 15 Feb 2012 11:23:22 -0800
Subject: [PATCH v2] ARM: OMAP: clock: cleanup CPUfreq leftovers
In-Reply-To: <1329333165-29646-1-git-send-email-khilman@ti.com>
References: <1329333165-29646-1-git-send-email-khilman@ti.com>
Message-ID: <CAORVsuUvv0Z36FK19J90uj8g16T9tvWzubpEF5s==wm_fXBB3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Kevin,

On Wed, Feb 15, 2012 at 11:12 AM, Kevin Hilman <khilman@ti.com> wrote:
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -272,7 +272,7 @@ struct clk {
> ?#endif
> ?};
>
> -struct cpufreq_frequency_table;
> +/* struct cpufreq_frequency_table; */
This needs to be removed.

Jean
