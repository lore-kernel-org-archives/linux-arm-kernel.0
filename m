From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Thu, 23 Dec 2010 21:33:19 +0530
Subject: Last OMAP4 hwmod data cleanup for 2.6.38
In-Reply-To: <4D135677.1080200@ti.com>
References: <4D135677.1080200@ti.com>
Message-ID: <20101223160319.GB1863@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 03:02:31PM +0100, Cousson, Benoit wrote:
> Hi Tony,
> 
> The merge of both SDMA series from Manju and SR series from Thara
> changed the expected order of the hwmod data structures for OMAP4.
> In order to have a clean base for 2.6.38, and to avoid starting
> 2.6.39 with a cleanup patch again, I'd like to fix that right now.
> Even if, I do agree, this is not a big deal.
> 
> I squeezed the 3 original small fixes I did (SDMA, SR and alignment)
> into one to avoid overloading your mailbox 2 days before Xmas.
> 
> The patch will be available here, based on omap-for-linus.
> git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_fixes
> 
> It should not affect any functionality, and it is boot tested on
> OMAP4430/sdp.

Boot tested on SDP4430 and all DMA tests passes as expected.

Tested-by: G, Manjunath Kondaiah <manjugk@ti.com>

-Manjunath
