From: rpurdie@rpsys.net (Richard Purdie)
Date: Thu, 22 Oct 2009 23:38:05 +0100
Subject: [PATCH] Zaurus: Fix NAND Flash OOB layout for Borzoi
In-Reply-To: <1256245503.9561.18.camel@utx.utx.cz>
References: <1256245503.9561.18.camel@utx.utx.cz>
Message-ID: <1256251085.23211.155.camel@dax.rpnet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-22 at 23:05 +0200, Stanislav Brabec wrote:
> Borzoi, Terrier and Akita use the same NAND Flash OOB layout, which
> seems to be different from Spitz for some reason. Here is a fix.
> 
> When the code was ported to the platform data, the map was applied just
> for Akita.
> 
> After this patch, Flash works again on Borzoi. Terrier still has a
> problem with partition table? different from Borzoi (unfixable without
> reading of the system configuration in flash) and JFFS2 partitions can
> be mounted (with some "Empty flash at ... ends at ..." in the syslog).
> 
> Signed-off-by: Stanislav Brabec <utx@penguin.cz>

Akita and Borzoi/Terrier share the same kind of flash so this match
almost certainly makes sense.

Acked-by: Richard Purdie <rpurdie@rpsys.net>

Cheers,

Richard


-- 
Richard Purdie
Intel Open Source Technology Centre
