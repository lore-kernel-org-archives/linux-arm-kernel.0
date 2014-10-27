From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 28 Oct 2014 01:01:38 +0200
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141027200008.GR2560@atomide.com>
References: <20141027200008.GR2560@atomide.com>
Message-ID: <20141027230138.GB7805@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> +
> +	if (!of_have_populated_dt())
> +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> +

Maybe use WARN so that the warning is more verbose and kernel gets tainted?

A.
