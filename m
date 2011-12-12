From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Dec 2011 13:49:52 +0000
Subject: [PATCH 4/4] ARM: smp_twd: reconfigure clockevents after
 cpufreq change
In-Reply-To: <1323683870-23937-1-git-send-email-linus.walleij@stericsson.com>
References: <1323683870-23937-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20111212134952.GW14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 10:57:50AM +0100, Linus Walleij wrote:
> +static int twd_cpufreq_init(void)
> +{
> +	if (!IS_ERR_OR_NULL(twd_clk))

IS_ERR()
