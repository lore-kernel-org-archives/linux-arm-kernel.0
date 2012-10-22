From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Oct 2012 09:30:45 +0100
Subject: [PATCH 1/2] ASoC: Ux500: Fixup complile errors due to merge
In-Reply-To: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121022083045.GA3785@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Oct 2012, Ulf Hansson wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Likely during merge of the below commits ended up breaking compilation:
> ASoC: Ux500: Enable ux500 MSP driver for Device Tree
> ASoC: ux500_msp_i2s: better use devm functions and fix error return code

This is already fixed:
  https://patchwork.kernel.org/patch/1593881/

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
