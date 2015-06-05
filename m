From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 5 Jun 2015 12:06:06 +0900
Subject: [RFT v2 06/48] pinctrl: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-7-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <CA+Ln22Euot24co7qKLTej43j3Z2BS-p5WhjRq9WgRb-+U=Tyqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2015-06-04 13:13 GMT+09:00 Jiang Liu <jiang.liu@linux.intel.com>:
> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/intel/pinctrl-cherryview.c    |    2 +-
>  drivers/pinctrl/intel/pinctrl-intel.c         |    2 +-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    4 ++--
>  drivers/pinctrl/nomadik/pinctrl-nomadik.c     |   12 +++++-------
>  drivers/pinctrl/pinctrl-amd.c                 |    2 +-
>  drivers/pinctrl/pinctrl-at91.c                |    2 +-
>  drivers/pinctrl/pinctrl-coh901.c              |    4 ++--
>  drivers/pinctrl/pinctrl-rockchip.c            |    4 ++--
>  drivers/pinctrl/pinctrl-single.c              |    2 +-
>  drivers/pinctrl/pinctrl-st.c                  |    6 +++---
>  drivers/pinctrl/qcom/pinctrl-msm.c            |    2 +-
>  drivers/pinctrl/samsung/pinctrl-exynos.c      |    8 ++++----
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c     |   18 +++++++++---------
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c     |   22 ++++++++++------------

For Samsung stuff:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
