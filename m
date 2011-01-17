From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 17 Jan 2011 11:03:08 +0000
Subject: [RFC+CFT] Use word operations in bitops
In-Reply-To: <20110116181551.GB21795@n2100.arm.linux.org.uk>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
	<20110116181551.GB21795@n2100.arm.linux.org.uk>
Message-ID: <20110117110308.GC2622@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 06:15:51PM +0000, Russell King - ARM Linux wrote:
> Revised patch - the previous one was slightly buggered for BE.  We also
> don't need to touch the findbit operations at all, so that part has been
> dropped.
> 
> This includes a patch by Akinobu Mita ("arm: introduce little-endian
> bitops", v4).

Oops, I hit reply to the wrong patch before.  Sorry!

Tested-by: Jamie Iles <jamie@jamieiles.com>

Jamie
