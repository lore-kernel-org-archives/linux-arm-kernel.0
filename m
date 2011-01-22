From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 21 Jan 2011 20:58:21 -0500
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
Message-ID: <20110122015821.GA6249@home.goodmis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 04:03:13PM -0800, Daniel Walker wrote:
> 
> right, but it wasn't a cherrypick which was explain in the thread. So
> there's no wrongs here ..

I'm sorry Daniel, but you are absolutely wrong!

Did you come up with the logic of this code, or did you take someone
else's code and just massage it until it worked?

If you took someone else's code, where are their Signed-off-by's?

Just look at what I did recently with Lai's rt-mutex clean up patch. I
ported it to the PREEMPT_RT (-rt) patch set. That port took me a week to
do. I had to add a bunch of code to make it work. When it was finished,
did I claim author of it? No! I left Lai as the author and simply added:

 [ Ported to the -rt patch set by Steven Rostedt ]

Take a look at the changes.

  Here's the patch I started with:

https://patchwork.kernel.org/patch/477841/

  Here's what I ended with (all my changes)

https://patchwork.kernel.org/patch/470171/

Do a diff of the two. There was a lot of work going into that. But I did
not come up with change to the algorithm that Lai did, so I kept him as
author. I just added my insert in the change log and added my own SoB
(including his).

If I repaint a Picasso, can I call it a Rostedt?

-- Steve
