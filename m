From: tytso@mit.edu (Ted Ts'o)
Date: Fri, 21 Jan 2011 21:31:38 -0500
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <1295654593.22882.9.camel@m0nster>
References: <20110121094827.41818a55@jbarnes-desktop>
	<20110121095658.1ab623fe@jbarnes-desktop>
	<1295632828.19880.22.camel@m0nster>
	<20110121100441.06a94482@jbarnes-desktop>
	<1295633882.19880.31.camel@m0nster>
	<AANLkTi=L+MW5-KLP_TKSxhstD8JEtBW=RKci5wSbZsd6@mail.gmail.com>
	<1295642995.19880.42.camel@m0nster>
	<AANLkTikVDn+W8t7KSym5tCGZowyYvoLFrk8d0mumiRF-@mail.gmail.com>
	<20110121234930.GK3043@thunk.org>
	<1295654593.22882.9.camel@m0nster>
Message-ID: <20110122023138.GQ3043@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 04:03:13PM -0800, Daniel Walker wrote:
> 
> right, but it wasn't a cherrypick which was explain in the thread. So
> there's no wrongs here ..

I said the *equivalent* of a cherry-pick.  And in general, if I'm
taking things from another git tree, I'll try to preserve the commit
structure as much as possible, preserve the Author: information, as
well as reference the original git tree and commit id's, and of
course, keep the signed-off-by's.  That's true even if I need to do
fairly significant work to port it to the current tree.

In some cases, of course, that might not be possible.  But in general,
it's much better to err on the side of including authorship than not.
Note the big uproar that happened when the code from BSD wireless
drivers were imported in without due care for attribution.  In the
case of pulling commits from another Linux kernel source tree, there
isn't even the excuse of needing to port from a completely different
OS's infrastructure.

If there is a desire to keep the git tree bisectable, and the order in
which things were checked in don't allow for tree bisectability, sure,
that might be a reason to collapse commits together; but even then,
I'd probably choose one of the Author's of the two original commits as
the Author field, instead of substituting my name in.

Best regards,

   	    	 	   		      - Ted
