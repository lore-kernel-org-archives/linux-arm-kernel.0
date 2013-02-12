From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Feb 2013 15:14:05 -0800
Subject: [GIT PULL] imx device tree changes for 3.9
In-Reply-To: <20130210154715.GB3983@S2101-09.ap.freescale.net>
References: <20130205030250.GC10807@S2101-09.ap.freescale.net>
 <20130205080642.GD16787@S2101-09.ap.freescale.net>
 <20130210022514.GB25302@quad.lixom.net>
 <20130210154715.GB3983@S2101-09.ap.freescale.net>
Message-ID: <20130212231405.GA25140@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 11:47:17PM +0800, Shawn Guo wrote:
> On Sat, Feb 09, 2013 at 06:25:14PM -0800, Olof Johansson wrote:
> > So, this has two merge conflicts. One with the cpuidle branch. Fine, that's
> > easy to resolve.
> > 
> > The one that's a real pain though, is the one with a fixes branch you
> > sent in, which changes _one property_, but throws a _HUGE_ merge conflict.
> > 
> > Why? Because you chose to do the churn on all the dtsi files. And this
> > is a conflict that would percolate all the way up so Linus sees it the way it
> > is now.
> > 
> Sorry, I forgot testing the merging between this and the last fixes tag.
> 
> > Please resolve this on your own and send out a new pull request. There's
> > a couple of ways to do it, either merge in your fixes branch, or rebase
> > on top of it.
> > 
> Done.  Please pull the refreshed tag below.
> 
> Shawn
> 
> 
> The following changes since commit d441667c7838d56bcace9a2465f0c1ff677bf2c0:
> 
>   Merge tag 'imx-fixes-3.8-4' into imx/dt (2013-02-10 23:23:47 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.9

Hi,

I've pulled this into a late/dt branch. I expect to send this up standalone to
Linus due to the amount of churn, since I don't want to risk other platforms
being rejected due to it.


-Olof
