From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Feb 2014 09:59:13 +0000
Subject: [PATCH v8 02/14] mfd: omap-usb-host: Always fail on clk_get()
 error
In-Reply-To: <1392896409-5101-3-git-send-email-rogerq@ti.com>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-3-git-send-email-rogerq@ti.com>
Message-ID: <20140225095913.GA13143@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Be more strict and always fail on clk_get() error.
> 
> For OMAP3 platforms, get the 120MHz EHCI clock by its proper name
> 'usbhost_120m_fck' instead of its alias 'ehci_logic_fck'.
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 65 +++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 23 deletions(-)

Appied, thanks.

--
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
