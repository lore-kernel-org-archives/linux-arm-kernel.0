From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 Mar 2016 08:47:16 +0100
Subject: [PATCH 18/22] ncr5380: Remove DONT_USE_INTR and AUTOPROBE_IRQ
 macros
In-Reply-To: <20160314042705.346693900@telegraphics.com.au>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042705.346693900@telegraphics.com.au>
Message-ID: <56E66C84.5050406@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 05:27 AM, Finn Thain wrote:
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
>  drivers/scsi/NCR5380.c   |   12 +-----------
>  drivers/scsi/NCR5380.h   |    4 ----
>  drivers/scsi/arm/oak.c   |    2 --
>  drivers/scsi/dmx3191d.c  |    2 --
>  drivers/scsi/dtc.c       |   12 +++---------
>  drivers/scsi/g_NCR5380.c |    2 --
>  drivers/scsi/pas16.c     |    1 -
>  drivers/scsi/t128.c      |    1 -
>  8 files changed, 4 insertions(+), 32 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
