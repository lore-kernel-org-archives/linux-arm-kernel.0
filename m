From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 15 May 2012 14:44:03 +0800
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add imx53 pinctrl driver
In-Reply-To: <1337010369-28687-1-git-send-email-b29396@freescale.com>
References: <1337010369-28687-1-git-send-email-b29396@freescale.com>
Message-ID: <20120515064401.GA10347@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 11:46:08PM +0800, Dong Aisheng-B29396 wrote:
> +See below for available PIN_FUNC_ID for imx53:
> +MX53_PAD_GPIO_19__KPP_COL_5				1
To align with mx6, the id base in the binding doc should start from 0.
Will update the doc in v2.

> +MX53_PAD_GPIO_19__GPIO4_5				2
> +MX53_PAD_GPIO_19__CCM_CLKO				3
> +MX53_PAD_GPIO_19__SPDIF_OUT1				4
> +MX53_PAD_GPIO_19__RTC_CE_RTC_EXT_TRIG2			5
> +MX53_PAD_GPIO_19__ECSPI1_RDY				6
...

Regards
Dong Aisheng
