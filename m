From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 15 May 2015 16:59:06 -0700
Subject: [RFC/PATCH 6/9] drivers: platform: Configure dma operations at
 probe time
In-Reply-To: <1431644410-2997-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1431644410-2997-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20150515235906.GA27219@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 02:00:07AM +0300, Laurent Pinchart wrote:
> Configuring DMA ops at probe time will allow deferring device probe when
> the IOMMU isn't available yet.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/base/platform.c | 9 +++++++++
>  drivers/of/platform.c   | 7 +++----
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
