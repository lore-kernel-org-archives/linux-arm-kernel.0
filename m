From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 Dec 2015 08:05:51 +0100
Subject: [PATCH v3 19/77] ncr5380: Cleanup bogus
 {request,release}_region() calls
In-Reply-To: <20151222011743.205522414@telegraphics.com.au>
References: <20151222011737.980475848@telegraphics.com.au>
 <20151222011743.205522414@telegraphics.com.au>
Message-ID: <5678F64F.2040509@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 02:17 AM, Finn Thain wrote:
> Commit 8b801ead3d7a ("[ARM] rpc: update Acorn SCSI drivers to modern ecard
> interfaces") neglected to remove a request_region() call in cumana_1.c.
>
> Commit eda32612f7b2 ("[PATCH] give all LLDD driver a ->release method") in
> history/history.git added some pointless release_region() calls in dtc.c,
> pas16.c and t128.c.
>
> Fix these issues.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
