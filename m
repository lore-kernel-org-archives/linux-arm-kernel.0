From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jun 2016 08:58:37 +0100
Subject: [PATCH 9/10] usb: host: ehci-st: Inform the reset framework that
 our reset line may be shared
In-Reply-To: <Pine.LNX.4.44L0.1606061344011.2049-100000@iolanthe.rowland.org>
References: <20160606170854.12407-2-lee.jones@linaro.org>
 <Pine.LNX.4.44L0.1606061344011.2049-100000@iolanthe.rowland.org>
Message-ID: <20160628075837.GK6720@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Jun 2016, Alan Stern wrote:

> On Mon, 6 Jun 2016, Lee Jones wrote:
> 
> > On the STiH410 B2120 development board the ST EHCI IP shares its reset
> > line with the OHCI IP.  New functionality in the reset subsystems forces
> > consumers to be explicit when requesting shared/exclusive reset lines.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> For this andd the 10/10 patch:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks Alan.

I'm going to take this (actually half of this patch -- the other half
which is due for -next I will resubmit with your Ack) along with the
other patches due for the -rcs though my MFD -next branch.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
