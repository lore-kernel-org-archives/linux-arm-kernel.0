From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 17:38:42 +0000
Subject: [GIT PULL 3/4] ARM: mvebu: dt changes for v3.9
In-Reply-To: <20130216200410.GJ23237@titan.lakedaemon.net>
References: <20130216200410.GJ23237@titan.lakedaemon.net>
Message-ID: <201302191738.43055.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Jason Cooper wrote:
> The following changes since commit 1bead82fa5a52cd21c30c0c28615157d5c3dac9f:
> 
>   arm: mvebu: add button for OpenBlocks AX3-4 (2013-01-31 20:44:08 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/dt_for_v3.9_round2
> 
> for you to fetch changes up to d892d02956c3cbe6835480a20ba553fbb0699666:
> 
>   arm: mvebu: enable the SD card slot on Armada 370 Reference Design board (2013-02-16 16:27:13 +0000)

I've merged them into late/mvebu-dt in order to get them into for-next,
but I don't think this is how we will get it merged upstream. Depending
on how things go, I think we will do one of three things:

* send this one as part of late/dt
* send it as part of late/mvebu
* defer it to 3.10

	Arnd
