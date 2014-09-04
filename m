From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 4 Sep 2014 10:39:44 +0100
Subject: [PATCH v6 2/3] mfd: qcom-rpm: Driver for the Qualcomm RPM
In-Reply-To: <1409029109-28769-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1409029109-28769-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1409029109-28769-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140904093944.GC1397@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Aug 2014, Bjorn Andersson wrote:

> Driver for the Resource Power Manager (RPM) found in Qualcomm 8660, 8960
> and 8064 based devices. The driver exposes resources that child drivers
> can operate on; to implementing regulator, clock and bus frequency
> drivers.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/mfd/Kconfig          |   14 +
>  drivers/mfd/Makefile         |    1 +
>  drivers/mfd/qcom_rpm.c       |  580 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/qcom_rpm.h |   10 +
>  4 files changed, 605 insertions(+)
>  create mode 100644 drivers/mfd/qcom_rpm.c
>  create mode 100644 include/linux/mfd/qcom_rpm.h

I'd like to take this in with the other MFD patch.

Is the regulator one okay to go in on it's own?

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
