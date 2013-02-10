From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Feb 2013 16:28:57 -0500
Subject: [PATCH 0/8] usb: ehci: more bus glues as separate modules
In-Reply-To: <5117edda.860e440a.097c.3507@mx.google.com>
References: <y>
 <5117edda.860e440a.097c.3507@mx.google.com>
Message-ID: <20130210212857.GJ14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Manjunath,

I think this is the second version of this series.  Please indicate so
in the subject "[PATCH V2 X/Y]" and provide a changelog with each patch
so that we can easily confirm suggested changes from one version to the
next.

thx,

Jason.

On Mon, Feb 11, 2013 at 12:28:09AM +0530, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the SOC On-Chip host controller driver from ehci-hcd 
> host code into its own driver module
> 
> Manjunath Goudar (8):
>   USB: EHCI: make ehci-spear a separate driver
>   USB: EHCI: make ehci-atmel a separate driver
>   USB: EHCI: make ehci-s5p a separate driver
>   USB: EHCI: make ehci-mv a separate driver
>   USB: EHCI: make ehci-vt8500 a separate driver
>   USB: EHCI: make ehci-msm a separate driver
>   USB: EHCI: make ehci-w90X900 a separate driver
>   USB: EHCI: make ehci-orion a separate driver
> 
>  drivers/usb/host/Kconfig        |   42 +++++++++++--
>  drivers/usb/host/Makefile       |    9 ++-
>  drivers/usb/host/ehci-atmel.c   |   77 ++++++++++++-----------
>  drivers/usb/host/ehci-hcd.c     |   52 +++-------------
>  drivers/usb/host/ehci-msm.c     |   85 +++++++++++--------------
>  drivers/usb/host/ehci-mv.c      |   80 +++++++++++-------------
>  drivers/usb/host/ehci-orion.c   |   91 +++++++++++++--------------
>  drivers/usb/host/ehci-s5p.c     |   69 ++++++++++++---------
>  drivers/usb/host/ehci-spear.c   |  131 ++++++++++++++++++++-------------------
>  drivers/usb/host/ehci-vt8500.c  |   73 ++++++++++------------
>  drivers/usb/host/ehci-w90x900.c |   90 ++++++++++++---------------
>  drivers/usb/host/ehci.h         |    2 +-
>  12 files changed, 392 insertions(+), 409 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
