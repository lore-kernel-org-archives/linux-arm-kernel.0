From: hare@suse.de (Hannes Reinecke)
Date: Mon, 06 Oct 2014 11:21:54 +0200
Subject: [PATCH 04/29] ncr5380: Remove unused macros
In-Reply-To: <20141002065629.216175491@telegraphics.com.au>
References: <20141002065628.256592712@telegraphics.com.au>
 <20141002065629.216175491@telegraphics.com.au>
Message-ID: <54325F32.4010804@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2014 08:56 AM, Finn Thain wrote:
> Some macros are never evaluated (i.e. FOO, USLEEP, SCSI2 and USE_WRAPPER; and 
> in some drivers, NCR5380_intr and NCR5380_proc_info). DRIVER_SETUP serves no
> purpose anymore. Remove these macro definitions.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
