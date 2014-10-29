From: hare@suse.de (Hannes Reinecke)
Date: Wed, 29 Oct 2014 16:57:11 +0100
Subject: [PATCH v2 08/36] ncr5380: Remove redundant AUTOSENSE macro
In-Reply-To: <20141027052609.075424749@telegraphics.com.au>
References: <20141027052607.105914311@telegraphics.com.au>
 <20141027052609.075424749@telegraphics.com.au>
Message-ID: <54510E57.5070408@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 06:26 AM, Finn Thain wrote:
> Every NCR5380 driver sets AUTOSENSE so it need not be optional (and the
> mid-layer expects it). Remove this redundant macro to improve readability.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
