From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Dec 2015 12:19:56 +0000
Subject: [PATCH] arm64: perf: Correct Cortex-A53/A57 compatible values
In-Reply-To: <20151215104242.GC9452@arm.com>
References: <1450168400-462-1-git-send-email-geert+renesas@glider.be>
 <20151215103659.GB31299@leverpostej>
 <20151215104242.GC9452@arm.com>
Message-ID: <20151217121955.GE11456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 10:42:42AM +0000, Will Deacon wrote:
> On Tue, Dec 15, 2015 at 10:37:00AM +0000, Mark Rutland wrote:
> > On Tue, Dec 15, 2015 at 09:33:20AM +0100, Geert Uytterhoeven wrote:
> > > Use commas instead of periods.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Cheers, Mark.
> 
> Rob -- do you want to pick this up, or shall I queue it on my perf
> branch?

Since it's so trivial and also has Mark's ack, I've queued this in the
ARM perf tree.

Will
