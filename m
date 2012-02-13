From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Feb 2012 16:02:49 +0000
Subject: [PATCH v7] ARM: net: JIT compiler for packet filters
In-Reply-To: <4F392DFD.4070600@gmail.com>
References: <1325937154-2656-1-git-send-email-mgherzan@gmail.com>
 <4F392DFD.4070600@gmail.com>
Message-ID: <20120213160248.GA25655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 04:36:29PM +0100, Mircea Gherzan wrote:
> Gentle ping. This patch has been in the tracking system for over a
> month. Is there any reason not to apply it in arm/for-next?

Yes.  It needs quite a review to make sure that there's absolutely no
possibility for userspace to be able to generate malicious ARM code
and then have it executed.  Or put it another way: security paranoia.

I'm afraid that I've not been able to look at it at all yet, and I
haven't seen anyone looking at the code from that aspect.
