From: hare@suse.de (Hannes Reinecke)
Date: Thu, 30 Oct 2014 08:36:10 +0100
Subject: [PATCH v2 15/36] ncr5380: Remove *_RELEASE macros
In-Reply-To: <20141027052610.755444813@telegraphics.com.au>
References: <20141027052607.105914311@telegraphics.com.au>
 <20141027052610.755444813@telegraphics.com.au>
Message-ID: <5451EA6A.7090708@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 06:26 AM, Finn Thain wrote:
> The *_RELEASE macros don't tell me anything. In some cases the version in
> the macro contradicts the version in the comments. Anyway, the Linux kernel
> version is sufficient information. Remove these macros to improve readability.
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
