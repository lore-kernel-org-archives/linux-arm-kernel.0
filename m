From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 4 Aug 2014 22:07:31 -0600 (MDT)
Subject: [PATCH 8/8] msm: scm: Move the scm driver to drivers/soc/qcom
In-Reply-To: <1407202310-3359-9-git-send-email-sboyd@codeaurora.org>
References: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
 <1407202310-3359-9-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.OSX.2.03.1408042203100.87047@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Aug 2014, Stephen Boyd wrote:

> Architectural changes in the ARM Linux kernel tree mandate
> the eventual removal of the mach-* directories. Move the
> scm driver to drivers/soc/qcom and the scm header to
> include/soc/qcom to support that removal.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-qcom/Kconfig                     | 3 ---
>  arch/arm/mach-qcom/Makefile                    | 4 +---
>  arch/arm/mach-qcom/scm-boot.c                  | 2 +-

 diff --git a/arch/arm/mach-qcom/scm.h b/include/soc/qcom/scm.h
> similarity index 100%
> rename from arch/arm/mach-qcom/scm.h
> rename to include/soc/qcom/scm.h

Could we move scm-boot.c as well to drivers/soc/qcom and scm-boot.h to include/soc/qcom ?
