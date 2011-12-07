From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Dec 2011 11:23:20 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111206233058.GZ14542@n2100.arm.linux.org.uk>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
 <20111206233058.GZ14542@n2100.arm.linux.org.uk>
Message-ID: <20111207112320.GB23720@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:30:58PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 06, 2011 at 02:07:29PM +0000, Catalin Marinas wrote:
> > This patch wasn't
> > originally part of my LPAE series as I hoped you would have merged it
> > during the last cycle. Now it had to be part of the pull request as LPAE
> > patches depend on it.
> 
> I've stated many times why it's not merged, and for the N'th time: it
> generates warnings.  I'm _not_ merging something that is known to add
> warnings such as those which this patch produces without there being a
> fix for it.  You know that _very well_ because I've said it several
> times, not only by email but also on our various phone calls.
> 
> I've dealt with this patch in exactly the same way at every merge window
> we've had for the last _year_ - I've queued it up with the expectation
> that hopefully someone would fix the warnings, the warnings didn't get
> fixed, so it got dropped from the pull request.  Immediately after the
> merge window (which includes this) it gets reinstated back into
> linux-next.

Yes, I'm fully aware, and I sent you a fix-up in the past. I can
re-write that fix-up in a few other ways if you don't like the current
one, just let me know.

-- 
Catalin
