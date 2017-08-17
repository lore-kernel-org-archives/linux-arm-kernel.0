From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Aug 2017 11:02:06 +0100
Subject: [PATCH 3/3] mfd: d1w: iproc: Add d1w driver
In-Reply-To: <1502905525-5646-4-git-send-email-scott.branden@broadcom.com>
References: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
 <1502905525-5646-4-git-send-email-scott.branden@broadcom.com>
Message-ID: <20170817100206.tqb5kluje6nr27ob@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Aug 2017, Scott Branden wrote:

> From: Shreesha Rajashekar <shreesha@broadcom.com>
> 
> d1w bus master controller is added as a mfd node.

Why?

> ds1wm driver is hooked to this node through the mfd framework.

Why?

What makes this an MFD device?

> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/mfd/Kconfig         |  11 +++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/bcm-iproc-d1w.c | 202 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/mfd/bcm-iproc-d1w.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
