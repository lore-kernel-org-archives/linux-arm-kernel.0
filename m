From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 3 Dec 2011 11:22:06 +0000
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20111203112206.GE6043@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2011 at 11:52:56AM +0200, Peter Ujfalusi wrote:

> @@ -0,0 +1,13 @@
> +* Texas Instruments OMAP4 Digital Microphone Module
> +
> +Required properties:
> +  - compatible : "ti,omap4-dmic"
> +  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
> +		 it is "dmic".

Actually thinking about this some more I think what's concerning me is
the documentation as much as anything else - if it was just an internal,
unpublished interface of the OMAP core code which happened to use device
tree I probably wouldn't have worried about it churning.
