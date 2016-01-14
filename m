From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 14 Jan 2016 05:01:39 +0000
Subject: [PATCH v2 2/2] mfd: add documentation for ACT8945A DT bindings
In-Reply-To: <201601122010.TpAuObtz%fengguang.wu@intel.com>
References: <1452585915-551-3-git-send-email-wenyou.yang@atmel.com>
 <201601122010.TpAuObtz%fengguang.wu@intel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63EBDC7@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

> -----Original Message-----
> From: kbuild test robot [mailto:lkp at intel.com]
> Sent: 2016?1?12? 20:55
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: kbuild-all at 01.org; Lee Jones <lee.jones@linaro.org>; Rob Herring
> <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark Rutland
> <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>; Kumar
> Gala <galak@codeaurora.org>; Javier Martinez Canillas <javier@dowhile0.org>;
> Krzysztof Kozlowski <k.kozlowski@samsung.com>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org; Yang, Wenyou
> <Wenyou.Yang@atmel.com>
> Subject: Re: [PATCH v2 2/2] mfd: add documentation for ACT8945A DT bindings
> 
> Hi Wenyou,
> 
> [auto build test ERROR on ljones-mfd/for-mfd-next] [also build test ERROR on
> v4.4 next-20160111] [if your patch is applied to the wrong git tree, please drop us
> a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Wenyou-Yang/mfd-act8945a-add-
> Active-semi-ACT8945A-PMIC-MFD-driver/20160112-161159
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: x86_64-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `act8945a_i2c_probe':
> >> act8945a.c:(.text+0x229476): undefined reference to `__devm_regmap_init_i2c'
>    drivers/built-in.o: In function `act8945a_i2c_init':
> >> act8945a.c:(.init.text+0x1a536): undefined reference to `i2c_register_driver'
>    drivers/built-in.o: In function `act8945a_i2c_exit':
> >> act8945a.c:(.exit.text+0x66f): undefined reference to `i2c_del_driver'

Thank you for your test, I will fix it.


Best Regards,
Wenyou Yang
