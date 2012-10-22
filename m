From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Oct 2012 09:33:59 +0100
Subject: [PATCH 2/2] ASoC: Ux500: Fixup compile error
In-Reply-To: <1350653427-28611-2-git-send-email-ulf.hansson@stericsson.com>
References: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
 <1350653427-28611-2-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121022083359.GB3785@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Oct 2012, Ulf Hansson wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The below commit introduced a compile error for a missing include file.
> ASoC: ux500_msp_i2s: better use devm functions and fix error return code

Already fixed:
  https://patchwork.kernel.org/patch/1593881/

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
