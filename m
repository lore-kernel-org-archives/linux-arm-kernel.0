From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Sep 2014 09:23:26 +0100
Subject: [PATCH v7 2/3] mfd: qcom-rpm: Driver for the Qualcomm RPM
In-Reply-To: <1411428329-23172-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1411428329-23172-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1411428329-23172-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140924082326.GG17801@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Sep 2014, Bjorn Andersson wrote:

> Driver for the Resource Power Manager (RPM) found in Qualcomm 8660, 8960
> and 8064 based devices. The driver exposes resources that child drivers
> can operate on; to implementing regulator, clock and bus frequency
> drivers.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
> 
> No functional changes since v6.

Then you should have applied my:

  Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/mfd/Kconfig          |   14 +
>  drivers/mfd/Makefile         |    1 +
>  drivers/mfd/qcom_rpm.c       |  580 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/qcom_rpm.h |   10 +
>  4 files changed, 605 insertions(+)
>  create mode 100644 drivers/mfd/qcom_rpm.c
>  create mode 100644 include/linux/mfd/qcom_rpm.h

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
