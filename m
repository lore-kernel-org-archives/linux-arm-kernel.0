From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon, 14 Feb 2011 16:12:16 +0100
Subject: Machine ID question
In-Reply-To: <20110210082915.GV27982@pengutronix.de>
References: <d6ddc34c-a962-4f4d-80b7-fc789606d899@VA3EHSMHS031.ehs.local>
	<20110210082915.GV27982@pengutronix.de>
Message-ID: <201102141612.17340.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 February 2011, 09:29:15 Uwe Kleine-K?nig wrote:
> On Wed, Feb 09, 2011 at 02:23:07PM -0700, John Linn wrote:
> > I used the form to create a new machine ID for the new Xilinx platform
> > in anticipation of
> > the code making it into the mainline sometime in the future.
> > 
> > The proposed patches are using ARCH_XILINX in the Kconfig.
> 
> You should use MACH_XILINX in the patches.  There are some ARCH_... in
> the machine db, but I think nowadays you cannot (and should not) create
> them there.

Uhm, the last entry in the db was created today (14th Feb). Is there a reason 
why there no new entries should be created?

Alexander
