From: hare@suse.de (Hannes Reinecke)
Date: Thu, 30 Oct 2014 08:37:28 +0100
Subject: [PATCH v2 16/36] ncr5380: Drop legacy scsi.h include
In-Reply-To: <20141027052611.005417244@telegraphics.com.au>
References: <20141027052607.105914311@telegraphics.com.au>
 <20141027052611.005417244@telegraphics.com.au>
Message-ID: <5451EAB8.6010805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 06:26 AM, Finn Thain wrote:
> Convert Scsi_Cmnd to struct scsi_cmnd and drop the #include "scsi.h".
> The sun3_NCR5380.c core driver already uses struct scsi_cmnd so converting
> the other core drivers reduces the diff which makes them easier to unify.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
Yippie! I was waiting for that to happen.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
