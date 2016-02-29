From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 16:18:37 +0100
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.6
In-Reply-To: <cover.1456442918.git.horms+renesas@verge.net.au>
References: <cover.1456442918.git.horms+renesas@verge.net.au>
Message-ID: <2850636.ecdOjeBnf0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 February 2016 08:51:45 Simon Horman wrote:
> Please consider these Renesas ARM64 based SoC defconfig updates for v4.6.
> 
> This pull request is based on the previous round of
> such requests, tagged as v4.5-rc2,
> which I have already sent a pull-request for.

It looks like your script generated a funny text here, as you
did not send -rc2 ;-)

> I based this pull request on v4.5-rc2 instead of rc1 to avoid
> a minor conflict. However I believe this may have been in vein
> as there appears to be a separate minor conflict present in linux-next.

Doesn't really matter here, the trivial conflicts are never a
problem, and the branches are already based on -rc3, so you are
not introducing a backmerge.

Pulled into next/arm64, thanks!

	Arnd
