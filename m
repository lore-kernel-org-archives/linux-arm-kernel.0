From: horms@verge.net.au (Simon Horman)
Date: Thu, 11 Apr 2013 12:09:13 +0900
Subject: [PATCH 1/2] ARM: r8a7740: Add interim sh-eth device name to
 clocks list
In-Reply-To: <20130109020647.GB6496@verge.net.au>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
 <20130109020647.GB6496@verge.net.au>
Message-ID: <20130411030913.GA13456@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 11:06:47AM +0900, Simon Horman wrote:
> On Tue, Dec 18, 2012 at 06:22:38PM +0100, Bastian Hecht wrote:
> > When we use the ethernet device via DT setup, we need to add it
> > to a lookup list until this is properly handled later in a DT-only
> > fashion.
> 
> Thanks, looks good.
> I will apply this.

Apparently I forgot to actually do that.
I have done so now, it is queued up for v3.11 in the soc-r8a7740 branch.
