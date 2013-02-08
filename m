From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 8 Feb 2013 10:23:31 -0500 (EST)
Subject: [PATCH 00/10] usb: ehci: more bus glues as separate modules
In-Reply-To: <5113e5b1.c84e420a.08c3.ffffbe1b@mx.google.com>
Message-ID: <Pine.LNX.4.44L0.1302081022280.1171-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Feb 2013 manjunath.goudar at linaro.org wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> 
> Separate the SOC On-Chip host controller driver from ehci-hcd
> host code into its own driver module.
> 
> Manjunath Goudar (10):
>   USB:Changed omap2plus_defconfig to support OMAP USB static driver
>   USB: EHCI: make ehci-omap a separate driver
>   USB: EHCI: make ehci-spear a separate driver
>   USB: EHCI: make ehci-orion a separate driver
>   USB: EHCI: make ehci-atmel a separate driver
>   USB: EHCI: make ehci-s5p a separate driver
>   USB: EHCI: make ehci-mv a separate driver
>   USB: EHCI: make ehci-vt8500 a separate driver
>   USB: EHCI: make ehci-msm a separate driver
>   USB: EHCI: make ehci-w90X900 a separate driver

I'm going on vacation for a week, so I won't be able to review these 
right away.  If you want to submit updated patches based on feedback 
from other people, go right ahead.

Alan Stern
