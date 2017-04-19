From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 07:06:39 -0700
Subject: [GIT PULL] ARM: aspeed: defconfig for 4.12
In-Reply-To: <CACPK8XdwSk8y7ZTnU=H3DA+_O1UOcQNvv57y-GzZA2z8-AOWdA@mail.gmail.com>
References: <CACPK8XdwSk8y7ZTnU=H3DA+_O1UOcQNvv57y-GzZA2z8-AOWdA@mail.gmail.com>
Message-ID: <20170419140639.GO29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 12:29:10PM +0930, Joel Stanley wrote:
> Hello Arnd, Olof,
> 
> These are the Aspeed defconfig changes for 4.12.
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-4.12-defconfig
> 
> for you to fetch changes up to 97bae47812dbbd220e354bc9f15c3b3c8b481a86:
> 
>   ARM: configs: aspeed: Add new drivers (2017-04-07 15:29:50 +0930)
> 
> ----------------------------------------------------------------
> Aspeed defconfig updates for 4.12
> 
> Add newly unstreamed drivers to the defconfigs for the Aspeed SoCs.

I highly recommend upstreaming drivers instead of unstreaming them. :-)

> The defconfigs are reworked to be useful for development and testing
> of OpenBMC on these systems.

Merged, thanks!


-Olof
