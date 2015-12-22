From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 Dec 2015 08:42:04 +0100
Subject: [PATCH v3 45/77] ncr5380: Cleanup #include directives
In-Reply-To: <20151222011750.245516745@telegraphics.com.au>
References: <20151222011737.980475848@telegraphics.com.au>
 <20151222011750.245516745@telegraphics.com.au>
Message-ID: <5678FECC.4090509@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 02:18 AM, Finn Thain wrote:
> Remove unused includes (stat.h, signal.h, proc_fs.h) and move includes
> needed by the core drivers into the common header (delay.h etc).
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
>   drivers/scsi/NCR5380.c       |    2 --
>   drivers/scsi/NCR5380.h       |    4 ++++
>   drivers/scsi/arm/cumana_1.c  |    4 ----
>   drivers/scsi/arm/oak.c       |    2 --
>   drivers/scsi/atari_NCR5380.c |    5 -----
>   drivers/scsi/atari_scsi.c    |    1 -
>   drivers/scsi/dmx3191d.c      |    5 -----
>   drivers/scsi/dtc.c           |    4 +---
>   drivers/scsi/g_NCR5380.c     |    6 ++----
>   drivers/scsi/mac_scsi.c      |    1 -
>   drivers/scsi/pas16.c         |    4 ----
>   drivers/scsi/t128.c          |    3 ---
>   12 files changed, 7 insertions(+), 34 deletions(-)
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
