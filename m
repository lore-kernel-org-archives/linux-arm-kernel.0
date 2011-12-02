From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Dec 2011 12:25:58 +0000
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20111202122558.GM8245@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:

> +Required properties:
> +  - compatible : "ti,omap4-dmic"
> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
> +		 it is "dmic".

Shouldn't there also be a regs property giving the register window?
