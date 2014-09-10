From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Sep 2014 20:22:43 +0200
Subject: [GIT PULL] ARM: LPC32xx: Platform specific core updates
In-Reply-To: <54105885.9020303@antcom.de>
References: <54105885.9020303@antcom.de>
Message-ID: <706522618.D4UDp8GaZm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 September 2014 15:56:21 Roland Stigge wrote:
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.antcom.de/linux-2.6 lpc32xx/core
> 
> for you to fetch changes up to 0816e792911ad8fb999862114e9a2ba805aa9753:
> 

Hi Roland,

I probably should have looked into the contents the first time around.
I have cherry-picked the reset fix into the next/fixes-non-critical,
but have decided not to apply the dma change for the same reason
as the respective DT changes.

	Arnd
