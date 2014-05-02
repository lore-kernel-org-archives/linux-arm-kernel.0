From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 2 May 2014 09:15:01 +0100
Subject: [PATCH v5 1/8] mfd: AXP20x: Add mfd driver for AXP20x PMIC
In-Reply-To: <1398947374-3115-2-git-send-email-carlo@caione.org>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-2-git-send-email-carlo@caione.org>
Message-ID: <20140502081501.GB5206@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch introduces the preliminary support for PMICs X-Powers AXP202
> and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> used by A10, A13 and A20 SoCs and developed by X-Powers, a sister company
> of Allwinner.
> 
> The core enables support for two subsystems:
> - PEK (Power Enable Key)
> - Regulators
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---

I guess I can just apply this and expect not to see any adverse
symptoms?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
