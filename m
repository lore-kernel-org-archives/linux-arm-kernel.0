From: horms@verge.net.au (Simon Horman)
Date: Tue, 1 Mar 2016 18:15:08 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.6
In-Reply-To: <2850636.ecdOjeBnf0@wuerfel>
References: <cover.1456442918.git.horms+renesas@verge.net.au>
 <2850636.ecdOjeBnf0@wuerfel>
Message-ID: <20160301091506.GA4363@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 04:18:37PM +0100, Arnd Bergmann wrote:
> On Friday 26 February 2016 08:51:45 Simon Horman wrote:
> > Please consider these Renesas ARM64 based SoC defconfig updates for v4.6.
> > 
> > This pull request is based on the previous round of
> > such requests, tagged as v4.5-rc2,
> > which I have already sent a pull-request for.
> 
> It looks like your script generated a funny text here, as you
> did not send -rc2 ;-)

Oops, I'll have to teach my script to be a bit smarter.

> > I based this pull request on v4.5-rc2 instead of rc1 to avoid
> > a minor conflict. However I believe this may have been in vein
> > as there appears to be a separate minor conflict present in linux-next.
> 
> Doesn't really matter here, the trivial conflicts are never a
> problem, and the branches are already based on -rc3, so you are
> not introducing a backmerge.
> 
> Pulled into next/arm64, thanks!
> 
> 	Arnd
