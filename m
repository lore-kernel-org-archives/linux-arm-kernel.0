From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 7 Nov 2012 16:55:58 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP: second set of PRCM cleanups for 3.8
In-Reply-To: <alpine.DEB.2.00.1211070227500.8758@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211011216130.26661@utopia.booyaka.com>
 <20121106220833.GQ6801@atomide.com>
 <alpine.DEB.2.00.1211070150100.8758@utopia.booyaka.com>
 <20121107015841.GC6801@atomide.com>
 <alpine.DEB.2.00.1211070227500.8758@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1211071655000.20704@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Nov 2012, Paul Walmsley wrote:

> On Tue, 6 Nov 2012, Tony Lindgren wrote:
> 
> > I'm getting errors with the allnoconfig ones, there are total four
> > omap defconfigs there not counting the randconfigs.
> 
> That might indeed explain the discrepancy; so far only have been building 
> his oldconfig seeds here.  Will add his allnoconfig seeds and test again.

Can reproduce this here.  Thanks for catching this.  Will fix and send a 
new pull request today and ensure that the two allnoconfigs are added to 
the build tests from now on.


- Paul
