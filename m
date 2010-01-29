From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 14:16:47 +0000
Subject: [RFC PATCH 03/12] arm: boot: update old ARM ID
In-Reply-To: <1264719577-5436-4-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-4-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129141647.GB16712@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 02:59:28PM -0800, Daniel Walker wrote:
> >From Steve Muckle's original patch,
> 
> The mask and ID pattern for older ARM IDs in the kernel
> decompressor matches the CPU ID for Scorpion, causing the
> v7 caching routines not to be run and kernel decompression
> to take significantly longer.

This pathc is actually only half the job - there's other stuff in the
kernel which would need updating in the same way.  I have a fuller
patch for this which I'll be queuing up for the next merge window
later today.
