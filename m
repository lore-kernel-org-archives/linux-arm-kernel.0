From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Oct 2015 14:04:26 -0700
Subject: [GIT PULL 2/2] omap device tree changes for v4.4
In-Reply-To: <8058507.49AsgX8PR9@wuerfel>
References: <8058507.49AsgX8PR9@wuerfel>
Message-ID: <20151015210425.GQ10113@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [151015 13:40]:
> On Wednesday 14 October 2015 14:38:59 Tony Lindgren wrote:
> 
> > Note that this branch is against v4.3-rc4 as that contains critical
> > MMC related fixes to boot with MMC working on most omaps.
> 
> While we are lucky this time as I based the branch on -rc4 anyway,
> a nicer way to do this would be to ensure that a fix you want
> to base on is based an older -rc, and then you base your own branch
> on top of that fix, to minimize the number of back-merged patches.

Sure that would be doable too at the cost of a few extra merges.

Regards,

Tony
