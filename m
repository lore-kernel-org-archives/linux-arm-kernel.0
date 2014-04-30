From: b32955@freescale.com (Huang Shijie)
Date: Wed, 30 Apr 2014 13:39:29 +0800
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <20140429190603.GB9418@norris-Latitude-E6410>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429190603.GB9418@norris-Latitude-E6410>
Message-ID: <20140430053926.GA9673@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 12:06:03PM -0700, Brian Norris wrote:
> OK, I'll try to split it up. Is ARM unique in tracking defconfigs in
> separate trees? I assume MIPS, PowerPC, and Blackfin won't require the
> same splitting? I'd like to avoid 31 patches when <20 could suffice.
> 
> I'll also rebase on linux-next. I think there may be a few conflicts.
Hi Brian:
  If we need to split the patch, please keep the mxs_defconfig and 
  imx_v6_v7_defconfig in a single patch,
  Shawn will review and merge or ack that patch.

  thanks
  Huang Shijie
