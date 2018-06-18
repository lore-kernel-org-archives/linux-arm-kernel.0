From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jun 2018 06:49:10 +0100
Subject: [PATCH v4 23/26] devicetree: fix a series of wrong file references
In-Reply-To: <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
Message-ID: <20180618054910.GB31141@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jun 2018, Mauro Carvalho Chehab wrote:

> As files got renamed, their references broke.
> 
> Manually fix a series of broken refs at the DT bindings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/pci/hisilicon-pcie.txt       |  2 +-
>  Documentation/devicetree/bindings/pci/kirin-pcie.txt |  2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt         |  4 ++--
>  .../devicetree/bindings/sound/st,stm32-i2s.txt       |  2 +-
>  .../devicetree/bindings/sound/st,stm32-sai.txt       |  2 +-
>  MAINTAINERS                                          | 12 ++++++------
>  8 files changed, 14 insertions(+), 14 deletions(-)

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
