From: tytso@mit.edu (Ted Ts'o)
Date: Fri, 21 Jan 2011 18:49:30 -0500
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <AANLkTikVDn+W8t7KSym5tCGZowyYvoLFrk8d0mumiRF-@mail.gmail.com>
References: <1295576730.4096.24.camel@Joe-Laptop>
	<1295624801.19880.13.camel@m0nster>
	<20110121094827.41818a55@jbarnes-desktop>
	<20110121095658.1ab623fe@jbarnes-desktop>
	<1295632828.19880.22.camel@m0nster>
	<20110121100441.06a94482@jbarnes-desktop>
	<1295633882.19880.31.camel@m0nster>
	<AANLkTi=L+MW5-KLP_TKSxhstD8JEtBW=RKci5wSbZsd6@mail.gmail.com>
	<1295642995.19880.42.camel@m0nster>
	<AANLkTikVDn+W8t7KSym5tCGZowyYvoLFrk8d0mumiRF-@mail.gmail.com>
Message-ID: <20110121234930.GK3043@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 11:05:54PM +0200, Pekka Enberg wrote:
> 
> On Fri, Jan 21, 2011 at 10:49 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> > I'll add this list into the commit text ..
> 
> So why is everyone bitching at Daniel when he's doing something the
> Android folks should have done themselves a long time ago?

Two wrongs don't make a right.  And it's not like not submitting
changes is wrong, although granted it's not ideal.  (I'd say removing
attribution from a git commit is even worse.  If you're doing the
equivalent of a cherry pick, you should preserve the Author field.
Even if you're doing some cleanup work, as the maintainer I generally
preserve the Author line, and will simply add the fact that I did some
cleanup to the commit body.  The question is who did more work; the
person who originally submitted the code, or the person who did the
cleanup.)

					- Ted
