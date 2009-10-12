From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Oct 2009 12:08:14 +0100
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
In-Reply-To: <4AD304B2.8000205@vflare.org>
References: <1255337423-3158-1-git-send-email-ngupta@vflare.org>
	<20091012090710.GA29310@n2100.arm.linux.org.uk>
	<4AD304B2.8000205@vflare.org>
Message-ID: <20091012110814.GA32113@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2009 at 03:58:02PM +0530, Nitin Gupta wrote:
> On 10/12/2009 02:37 PM, Russell King - ARM Linux wrote:
> > On Mon, Oct 12, 2009 at 02:20:23PM +0530, Nitin Gupta wrote:
> >> Same problem exists on mips too.
> > 
> > Nice catch.  This logic came from sparc64, so I think you'd want to talk
> > to davem about it as well.
> > 
> > In the mean time, submitting your fix to the patch system would be great,
> > thanks.
> > 
> 
> Thanks for looking into this. I think this can make it to mainline if
> you could Ack it and perhaps CC Andrew to get his attention?

Or it could take a less tortuous route by going through my tree.
