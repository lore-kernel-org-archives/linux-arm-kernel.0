From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Jan 2014 13:49:43 -0500
Subject: [PATCH] ARM: orion: provide C-style interrupt handler for
 MULTI_IRQ_HANDLER
In-Reply-To: <52D82802.6090104@gmail.com>
References: <1389775235.10695.51.camel@dagon.hellion.org.uk>
 <1389859831-9883-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140116164833.GH29184@titan.lakedaemon.net>
 <1389891087.6697.26.camel@kazak.uk.xensource.com>
 <20140116165347.GI29184@titan.lakedaemon.net>
 <52D82802.6090104@gmail.com>
Message-ID: <20140116184943.GK29184@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 07:42:10PM +0100, Sebastian Hesselbarth wrote:
...
> Out of curiosity, does that adding the Cc tag to the commit queue
> it automatically as soon as it will be pulled by Linus?

Yes.  The -stable team scans commits as they are added to Linus' tree.
If it has that tag, then they cherrypick it for the appropriate trees.
As do many vendors and distros.

There's no need to actually "email Cc" stable, they won't take it until
it's landed in mainline.  iirc, this generates a form letter from Greg
:)

> @Ian: Thanks for hunting this down, please keep bothering us with
> bug reports :)

Yes, please!

thx,

Jason.
