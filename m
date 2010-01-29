From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Jan 2010 06:36:11 -0800
Subject: [RFC PATCH 03/12] arm: boot: update old ARM ID
In-Reply-To: <20100129141647.GB16712@n2100.arm.linux.org.uk>
References: <1264719577-5436-4-git-send-email-dwalker@codeaurora.org>
	<20100129141647.GB16712@n2100.arm.linux.org.uk>
Message-ID: <1264775771.5109.44.camel@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-29 at 14:16 +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 28, 2010 at 02:59:28PM -0800, Daniel Walker wrote:
> > >From Steve Muckle's original patch,
> > 
> > The mask and ID pattern for older ARM IDs in the kernel
> > decompressor matches the CPU ID for Scorpion, causing the
> > v7 caching routines not to be run and kernel decompression
> > to take significantly longer.
> 
> This pathc is actually only half the job - there's other stuff in the
> kernel which would need updating in the same way.  I have a fuller
> patch for this which I'll be queuing up for the next merge window
> later today.

Great.. I'll drop this one.

Daniel
