From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 12:54:01 -0400
Subject: [PATCH 00/10] clk: mvebu: restructure SoC clock drivers
In-Reply-To: <20130528175343.77c6353d@skate>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130528154047.GT31290@titan.lakedaemon.net>
 <20130528175343.77c6353d@skate>
Message-ID: <20130528165401.GX31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 05:53:43PM +0200, Thomas Petazzoni wrote:
> On Tue, 28 May 2013 11:40:47 -0400, Jason Cooper wrote:
> > I'm posting the revised version as replies to patches 1, 5 and 6. Please
> > let me know if I messed it up.  I'd like to send the PR for these
> > shortly.
> 
> I had a quick look, and it looks good to me. Let me know to which
> branch you've pushed this, and the merge order to follow to "rebuild"
> something that works, and I'll try to find some time to test it for
> real on hardware.

$ git checkout v3.10-rc3
$ git merge mvebu/of_pci
$ git merge mvebu/pcie
$ git merge mvebu/seb_clk

test away!

thx,

Jason.
