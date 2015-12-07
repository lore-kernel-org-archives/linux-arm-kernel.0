From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 07 Dec 2015 13:33:55 +0300
Subject: [PATCH 0/2] net: thunderx: Miscellaneous cleanups
In-Reply-To: <1449464433-43343-1-git-send-email-sunil.kovvuri@gmail.com>
References: <y@samsung.com>
 <1449464433-43343-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <014f01d130da$c72c2d60$55848820$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Tested-by: Pavel Fedin <p.fedin@samsung.com>

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia


> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On Behalf Of Sunil
> Goutham
> Sent: Monday, December 07, 2015 8:01 AM
> To: netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; p.fedin at samsung.com;
> Sunil.Goutham at caviumnetworks.com; Sunil Goutham
> Subject: [PATCH 0/2] net: thunderx: Miscellaneous cleanups
> 
> From: Sunil Goutham <sgoutham@cavium.com>
> 
> This patch series contains contains couple of cleanup patches.
> 
> Sunil Goutham (1):
>   net, thunderx: Remove unnecessary rcv buffer start address management
> 
> Yury Norov (1):
>   net: thunderx: nicvf_queues: nivc_*_intr: remove duplication
> 
>  drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  189 +++++---------------
>  drivers/net/ethernet/cavium/thunder/nicvf_queues.h |   10 +-
>  2 files changed, 51 insertions(+), 148 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
