From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 24 Jul 2014 12:20:55 +0100
Subject: [PATCH v2 1/3] usb: host: st-hcd: Add USB HCD support for STi SoCs
In-Reply-To: <1406199616-10533-2-git-send-email-peter.griffin@linaro.org>
References: <1406199616-10533-1-git-send-email-peter.griffin@linaro.org>
 <1406199616-10533-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140724112055.GC7063@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Jul 2014, Peter Griffin wrote:

> This driver adds support for the USB HCD present in STi
> SoC's from STMicroelectronics. It has been tested on the
> stih416-b2020 board.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/usb/host/Kconfig  |  12 ++
>  drivers/usb/host/Makefile |   1 +
>  drivers/usb/host/st-hcd.c | 460 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 473 insertions(+)
>  create mode 100644 drivers/usb/host/st-hcd.c

Looks good to me now:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
