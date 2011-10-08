From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Oct 2011 23:07:22 +0100
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
In-Reply-To: <20111008192621.GA28049@pengutronix.de>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20111008192621.GA28049@pengutronix.de>
Message-ID: <20111008220722.GG25689@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2011 at 09:26:21PM +0200, Wolfram Sang wrote:
> On Sat, Oct 08, 2011 at 05:19:48PM +0200, Gwenhael Goavec-Merou wrote:
> > 
> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> 
> I think this file is maintained by Russell, yet I want to ack that the entry
> below is missing for building mx1_defconfig. Found that, too.

The thing is - read the comments at the top of the file.  There's hints
there as to what will happen if you patch the file.  The hint is
'automatically generated'.  So when I next update the file, any patches
done to the file will be wiped out.
