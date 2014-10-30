From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 30 Oct 2014 17:20:20 +0000
Subject: [RFC PATCH 1/1] arm64: Fix up /proc/cpuinfo
In-Reply-To: <20141030171521.GL32589@arm.com>
References: <1414159000-27059-1-git-send-email-mark.rutland@arm.com>
 <1414159000-27059-2-git-send-email-mark.rutland@arm.com>
 <20141030171521.GL32589@arm.com>
Message-ID: <1414689620.11523.5.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-30 at 17:15 +0000, Will Deacon wrote:
> Hi Mark,
> 
> On Fri, Oct 24, 2014 at 02:56:40PM +0100, Mark Rutland wrote:
> > Commit d7a49086f263164a (arm64: cpuinfo: print info for all CPUs)
> > attempted to clean up /proc/cpuinfo, but due to concerns regarding
> > further changes was reverted in commit 5e39977edf6500fd (Revert "arm64:
> > cpuinfo: print info for all CPUs").
> 
> I've applied this on our devel branch, with a view to queuing it for -next
> in a week or two. I think we should also CC stable on this, so could you
> see how far back it applies please? (note that I already had to resolve
> a conflict with a patch we've got queued from Ard).

<dons Debian hat>

Since we'll be shipping 3.16 in our next release I'd love to see it go
back at least as far as that ;-)

(I'd likely apply it myself even if it doesn't appear via stable).

Ian.
