From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Apr 2014 08:39:26 +0100
Subject: [PATCH 1/3] arm: dts: add device_type="memory" for ste-ccu8540
In-Reply-To: <1397756521-29387-2-git-send-email-leif.lindholm@linaro.org>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-2-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140422073926.GC17657@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The current .dts for ste-ccu8540 lacks a 'device_type = "memory"' for
> its memory node, relying on an old ppc quirk in order to discover its
> memory. Add this, to permit that quirk to be made ppc only.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/ste-ccu8540.dts |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
