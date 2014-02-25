From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Feb 2014 10:28:59 +0000
Subject: [PATCH v8 02/14] mfd: omap-usb-host: Always fail on clk_get()
 error
In-Reply-To: <20140225095913.GA13143@lee--X1>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-3-git-send-email-rogerq@ti.com>
 <20140225095913.GA13143@lee--X1>
Message-ID: <20140225102859.GB13246@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Feb 2014, Lee Jones wrote:

> > Be more strict and always fail on clk_get() error.
> > 
> > For OMAP3 platforms, get the 120MHz EHCI clock by its proper name
> > 'usbhost_120m_fck' instead of its alias 'ehci_logic_fck'.
> > 
> > CC: Lee Jones <lee.jones@linaro.org>
> > CC: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  drivers/mfd/omap-usb-host.c | 65 +++++++++++++++++++++++++++++----------------
> >  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> Appied, thanks.

Won't apply. I guess this depends on the changes made in patch 1.

I'll wait for the next drop.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
