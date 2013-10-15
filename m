From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 15 Oct 2013 08:19:03 -0700
Subject: [PATCH V2 1/7] USB: OHCI: Properly handle OHCI controller suspend
In-Reply-To: <1381843202-28707-2-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1381843202-28707-1-git-send-email-csmanjuvijay@gmail.com>
 <1381843202-28707-2-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <20131015151903.GE18794@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 06:49:56PM +0530, Majunath Goudar wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Suspend scenario in case of OHCI was not properly
> handled in ochi_suspend()routine. Alan Stern
> suggested, properly handle OHCI suspend scenario.
> 
> This does generic proper handling of suspend
> scenario to all OHCI SOC.
> 
> V1->V2:
>      - No change. 
>        Due to build failure on ep93xx reverted this patch. This patch is 
>        needed as Alan mentioned, it is having common ohci suspend features 
>        w/o this following patches(still in usb-next) are not useful.
> 
>         Commit id "10abfa13"[PATCH 7/11] Properly handle ohci-omap suspend.
>         Commit id "39dbd7df"[PATCH 8/11] Properly handle ohci-platform suspend.
>         Commit id "4ceaa893"[PATCH 9/11] Properly handle ohci-pxa suspend.
>         Commit id "f3c60599"[PATCH 10/11] Properly handle ohci-sm501 suspend.
>  
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>

This is an invalid email address, please don't continue to use it, I'm
tired of seeing the bounce response :(

And "v2" for this series?  Really?  I seem to recall many different
versions of the series, so we should be on a much higher number by
now...

How have you tested these patches?

thanks,

greg k-h
