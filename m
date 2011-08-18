From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 18 Aug 2011 17:02:02 +0100
Subject: [PATCH 0/3] Device Tree support for Picochip picoXcell
In-Reply-To: <1312884661-27205-1-git-send-email-jamie@jamieiles.com>
References: <1312884661-27205-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110818160202.GF2811@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 11:10:58AM +0100, Jamie Iles wrote:
> This series adds initial support for Picochip picoXcell devices.  I've based
> this off of Grant's devicetree/test branch and also on top of Russell's GPIO
> includes cleanup.
> 
> I have a second set of patches that add clk support but I've left them out for
> now to keep the changes to a minimum.
> 
> Jamie Iles (3):
>   picoxcell: support for Picochip picoxcell devices
>   picoxcell: add the DTS for pc3x2 and pc3x3 devices
>   picoxcell: add the DTS for the PC7302 board

Does anyone have any feedback on these?  I've identified a couple of 
changes for a v2, in particular using of_platform_populate rather than 
of_platform_probe() and cleaning up some empty headers.  I could also 
take advantage of Russell's io.h cleanup and Marc's sched_clock() if 
they get merged first.

Jamie
