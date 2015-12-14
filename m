From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Dec 2015 15:27:22 +0900
Subject: [PATCH] serial: sh-sci: Add device tree support for r8a779[23]
In-Reply-To: <20151213065250.GA2230@kroah.com>
References: <1448587224-8633-1-git-send-email-horms+renesas@verge.net.au>
 <20151213065250.GA2230@kroah.com>
Message-ID: <20151214062722.GH18143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 10:52:50PM -0800, Greg Kroah-Hartman wrote:
> On Fri, Nov 27, 2015 at 10:20:24AM +0900, Simon Horman wrote:
> > Simply document new compat strings.
> > There appears to be no need for a driver updates.
> > 
> > Also update the name of the r8a7791 to M2-W: the name changed a while back.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Doesn't apply to my tree :(

I'm a little confused.

The tty-next branch of the tty tree seems to be v4.4-rc5.
And the patch seems to apply there. Please let me know what
I should be using as a base.
