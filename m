From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 8 Dec 2016 03:35:24 +0200
Subject: [PATCH v2 3/3] USB: OHCI: nxp: remove useless extern declaration
In-Reply-To: <1481150056-3623-4-git-send-email-csmanjuvijay@gmail.com>
References: <1480735523-23950-1-git-send-email-csmanjuvijay@gmail.com>
 <1481150056-3623-1-git-send-email-csmanjuvijay@gmail.com>
 <1481150056-3623-4-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <5040084d-3d99-b07e-ceab-3e849dc4c472@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2016 12:34 AM, csmanjuvijay at gmail.com wrote:
> From: Manjunath Goudar <csmanjuvijay@gmail.com>
> 
> Remove usb_disabled() extern declaration as it is already declared
> as extern in include/linux/usb.h.
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-usb at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
> changelog V1->V2:
> patch discrition is update with proper message.
> 

I'm fine with the change, thank you for the clean-up.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
