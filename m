From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 13:50:27 -0000
Subject: [PATCH 5/8] ARM: hw_breakpoint: don't advertise reserved
	breakpoints
In-Reply-To: <20101130110243.GD4398@pulham.picochip.com>
References: <1291052088-17243-1-git-send-email-will.deacon@arm.com>
	<1291052088-17243-6-git-send-email-will.deacon@arm.com>
	<20101130100100.GA4398@pulham.picochip.com>
	<004001cb9077$25b2e4a0$7118ade0$@deacon@arm.com>
	<20101130110243.GD4398@pulham.picochip.com>
Message-ID: <004501cb9095$8bd9ba60$a38d2f20$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Currently, all the code above ends up doing is checking that we have more than
> > 1 breakpoint available if we want watchpoints.
> >
> > I could update the comment to say that we might advertise 0 watchpoints in the
> > case that only 1 breakpoint is available if you like?
> It was more out of curiosity really! If you're in there again it might be
> worth updating the comment otherwise it's not obvious why the code doesn't
> just return a static 1.

I've updated the comment so you should see it in v3!

Will
