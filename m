From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jun 2013 10:59:49 +0100
Subject: Armada DRM driver on OLPC XO
In-Reply-To: <20130625204726.BF65C12647A@dev.laptop.org>
References: <20130625204726.BF65C12647A@dev.laptop.org>
Message-ID: <20130627095949.GD4283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 04:47:26PM -0400, Daniel Drake wrote:
> Hi Russell,
> 
> Thanks a lot for writing the Armada DRM driver.
> 
> I have tested it on OLPC XO-1.75 (MMP2 aka Armada610) and OLPC XO-4 (MMP3
> aka PXA2128). After a bit of fighting, I have it running. Could you share your
> X driver, or your methodology for testing hardware cursors? I'd like to test
> your work there too.
> 
> It's probably easiest to get your cubox driver merged before adding MMP2/MMP3
> complications into the mix. At that point, I will hopefully have time to
> follow up developing MMP2/MMP3 support, which will involve the points
> mentioned below.

As a side note, you've looked at a previous generation of the patches -
in that same thread, there are two versions of these patches.  The original
set was an older version that I mis-posted.

The later version removes the clock handling for the LCDs out of
armada_crtc.c into armada_drv.c.
