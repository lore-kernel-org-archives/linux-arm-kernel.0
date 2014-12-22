From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 13:45:51 +0000
Subject: [PATCH v3 1/5] ASoC: dwc: Ensure FIFOs are flushed to prevent
 channel swap
In-Reply-To: <8f40608d5665e80bfd3e9723784ec3bc2078e0d2.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <8f40608d5665e80bfd3e9723784ec3bc2078e0d2.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <20141222134551.GO17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 04:18:05PM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> Flush the FIFOs when the stream is prepared for use.  This avoids
> an inadvertent swapping of the left/right channels if the FIFOs are
> not empty at startup.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/aecf3a29/attachment.sig>
