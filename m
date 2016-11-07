From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2016 16:25:06 -0700
Subject: [PATCH] ARM: OMAP2+: avoid NULL pointer dereference
In-Reply-To: <1477993765-9980-1-git-send-email-Nicolae_Rosia@mentor.com>
References: <1477993765-9980-1-git-send-email-Nicolae_Rosia@mentor.com>
Message-ID: <20161107232505.GG2428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolae Rosia <Nicolae_Rosia@mentor.com> [161101 02:50]:
> For OMAP4, volt_data is set in omap44xx_voltagedomains_init.
> If the SoC is neither OMAP443X or OMAP446X, we end up with a
> NULL in volt_data which causes a kernel oops.
> This is the case when booting OMAP4470.

Thanks applying into omap-for-v4.9/fixes.

Tony
