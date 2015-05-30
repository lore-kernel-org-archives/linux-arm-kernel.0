From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 30 May 2015 14:12:10 +0000
Subject: [GIT PULL] ARM: mvebu: drivers changes for v4.2
In-Reply-To: <5568DF81.1090300@free-electrons.com>
References: <5568DF81.1090300@free-electrons.com>
Message-ID: <20150530141210.GE13641@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Gregory,

On Fri, May 29, 2015 at 11:52:01PM +0200, Gregory CLEMENT wrote:
> Hi,
> 
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
> ----------------------------------------------------------------
> Thomas Petazzoni (1):
>       bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()
> 
>  drivers/bus/mvebu-mbus.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mbus.h     |   5 +++++
>  2 files changed, 122 insertions(+)
> 

I don't see this in mvebu/for-next...  Not earth shattering, just mentioning
it.  This commit is adding a new function with no callers, so the chances of
conflicts / build failures is minimal.

thx,

Jason.
