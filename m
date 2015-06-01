From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:04:19 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.1 #3
In-Reply-To: <5568DF7A.9090600@free-electrons.com>
References: <5568DF7A.9090600@free-electrons.com>
Message-ID: <2169801.07m6BsynfT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 23:51:54 Gregory CLEMENT wrote:
> mvebu fixes for 4.1 (part 3)
> 
> Disable unused internal RTC for Mamba from linksys (Armada XP)
> And 2 commits fixing regressions on mvebu-mbus:
> - the first one for Kirkwood or Orion SoC
> - the second one for DMA when the platform have more than 4GB (only
>   possible on Armada XP as far as I know)
> 

Pulled into fixes, thanks!

	Arnd
