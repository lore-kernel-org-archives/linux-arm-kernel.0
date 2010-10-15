From: greg@kroah.com (Greg KH)
Date: Fri, 15 Oct 2010 12:10:05 -0700
Subject: [PATCH] mxc_udc: add workaround for ENGcm09152 for i.MX35
In-Reply-To: <1287145858-10239-1-git-send-email-eric@eukrea.com>
References: <1287145858-10239-1-git-send-email-eric@eukrea.com>
Message-ID: <20101015191005.GB8098@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 02:30:58PM +0200, Eric B?nard wrote:
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX35 when the hardware workaround is also implemented on
> the board.
> It covers the workaround described on page 25 of the following Errata :
> http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf 
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx3/mach-cpuimx35.c |    1 +
>  drivers/usb/gadget/fsl_mxc_udc.c  |   15 +++++++++++++++
>  include/linux/fsl_devices.h       |    3 +++
>  3 files changed, 19 insertions(+), 0 deletions(-)

Do you want me to take this through my usb tree, or will it go through
some other developer's tree?

Either is fine with me.

thanks,

greg k-h
