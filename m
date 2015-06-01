From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:36:44 +0200
Subject: [GIT PULL] ARM: mvebu: drivers changes for v4.2
In-Reply-To: <5568DF81.1090300@free-electrons.com>
References: <5568DF81.1090300@free-electrons.com>
Message-ID: <12169869.A5OKQoShWP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 May 2015 23:52:01 Gregory CLEMENT wrote:
> Here is the first pull request for drivers for mvebu for v4.2.
> It depends on the mvebu/fixes branch which have been merged in the
> mvebu/drivers branch
> 
> Gregory
> 
> The following changes since commit 885dbd154b2f2ee305cec6fd0a162e1a77ae2b06:
> 
>   Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window" (2015-05-28 11:14:31 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-drivers-4.2
> 
> for you to fetch changes up to bfa1ce5f38938cc9e6c7f2d1011f88eba2b9e2b2:
> 
>   bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap() (2015-05-28 12:21:08 +0200)
> 
> ----------------------------------------------------------------
> mvebu drivers change for 4.2
> 
> mvebu-mbus: add mv_mbus_dram_info_nooverlap() needed for the new
> Marvell crypto driver
> 
> 

Merged into the next/drivers branch. I've added an explanation about
the fixes branch into the commit message, this is something that
would be helpful to have in the tag description as well (so I
don't have to write it myself).

Thanks!

	Arnd
