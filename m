From: tabbott@ksplice.com (Tim Abbott)
Date: Tue, 13 Oct 2009 12:47:45 -0400 (EDT)
Subject: [PATCH v4 2/2] arm: Clean up linker script using new linker
	script macros.
In-Reply-To: <20091013085003.GB3194@pengutronix.de>
References: <alpine.DEB.1.10.0910021536510.19358@dr-wily.mit.edu>
	<1254515567-27110-2-git-send-email-tabbott@ksplice.com>
	<alpine.DEB.1.10.0910121036130.6253@dr-wily.mit.edu>
	<20091013085003.GB3194@pengutronix.de>
Message-ID: <alpine.DEB.1.10.0910131147090.2868@dr-wily.mit.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Oct 2009, Uwe Kleine-K?nig wrote:

> On Mon, Oct 12, 2009 at 10:41:10AM -0400, Tim Abbott wrote:
> > Can someone with an arm machine test this patch?  I'd really appreciate 
> > it.
> Compiles and is running fine on eco920.

Thanks!

Russell, are you willing to take this patch series for 2.6.32?  It would 
make life a lot easier for my work on building the kernel with 
-ffunction-sections -fdata-sections targeted at 2.6.33 if these linker 
script cleanups for the last couple architectures made it into 2.6.32.

	-Tim Abbott
