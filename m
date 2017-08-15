From: xuwei5@hisilicon.com (Wei Xu)
Date: Tue, 15 Aug 2017 14:33:46 +0100
Subject: [PATCH v2 0/6] arm64: defconfig: enable configs for HiKey960
In-Reply-To: <20170810023728.19621-1-guodong.xu@linaro.org>
References: <20170810023728.19621-1-guodong.xu@linaro.org>
Message-ID: <5992F83A.6050407@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

On 2017/8/10 3:37, Guodong Xu wrote:
> This patchset enables config items in arm64/defconfig for HiKey960. All
> of them correspond to real functions on HiKey960.
> 
> Including:
>  - Kirin PCIe
>  - PMIC support, hi6421v530
>  - syscon reboot mode
>  - serdev bus
>  - OP-TEE
>  - K3 DMA
> 
> HiKey960 is one of 96boards. For details information about it, please
> refer to [1].
> 
> [1] https://github.com/96boards/documentation/tree/master/ConsumerEdition/HiKey960
> 
> ===
> Major changes in v2:
>  - Add patch 6 to enable K3 DMA
> 
> Guodong Xu (3):
>   arm64: defconfig: enable support hi6421v530 PMIC
>   arm64: defconfig: enable CONFIG_SYSCON_REBOOT_MODE
>   arm64: defconfig: enable support for serial port connected device
> 
> Victor Chong (1):
>   arm64: defconfig: enable OP-TEE
> 
> Wang Ruyi (1):
>   arm64: defconfig: enable DMA driver for hi3660
> 
> Xiaowei Song (1):
>   arm64: defconfig: enable Kirin PCIe
> 
>  arch/arm64/configs/defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Thanks!
Series applied to the hisilicon defconfig tree.

BR,
Wei
