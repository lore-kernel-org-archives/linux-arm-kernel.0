From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Oct 2013 08:56:05 -0700
Subject: [PATCH v3 08/10] mfd: pm8x41: add support for Qualcomm 8x41 PMICs
In-Reply-To: <5a49bffc44c5f5bffe222560e489a712321ce971.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <5a49bffc44c5f5bffe222560e489a712321ce971.1382985169.git.joshc@codeaurora.org>
Message-ID: <20131029155605.GE4231@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Oct 2013, Josh Cartwright wrote:

> The Qualcomm 8941 and 8841 PMICs are components used with the Snapdragon
> 800 series SoC family.  This driver exists largely as a glue mfd component,
> it exists to be an owner of an SPMI regmap for children devices
> described in device tree.
> 
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
>  drivers/mfd/Kconfig  | 10 ++++++++
>  drivers/mfd/Makefile |  1 +
>  drivers/mfd/pm8x41.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++

Can you CC me on your next submission, or it may not get applied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
