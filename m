From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Oct 2013 08:21:22 -0700
Subject: [PATCH 1/4] mfd: as3722: add clock driver as mfd-sub device for
 the ams AS3722
In-Reply-To: <1383049205-29620-2-git-send-email-ldewangan@nvidia.com>
References: <1383049205-29620-1-git-send-email-ldewangan@nvidia.com>
 <1383049205-29620-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <20131029152122.GD4231@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Oct 2013, Laxman Dewangan wrote:

> Device ams AS3722 supports the one 32KHz clock output. The clock control
> support is provided through clock driver.
> 
> Add clock driver as mfd sub device to probe the clock driver.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mfd/as3722.txt |    9 +++++++++
>  drivers/mfd/as3722.c                             |    3 +++

You need to seperate the DT binding from the drivers/mfd changes.

The MFD changes are fine of course.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
