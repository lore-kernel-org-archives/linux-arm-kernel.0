From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 09:40:37 -0500
Subject: [PATCH v3] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <20130123142933.GO1758@titan.lakedaemon.net>
References: <3816648.2TVsTiMOWx@bender>
 <1358174852-19752-1-git-send-email-florian@openwrt.org>
 <20130123142933.GO1758@titan.lakedaemon.net>
Message-ID: <20130123144037.GQ1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 09:29:33AM -0500, Jason Cooper wrote:
> On Mon, Jan 14, 2013 at 03:47:32PM +0100, Florian Fainelli wrote:
> > This patch adds the DTS file to support the Marvell RD-A370-A1
> > (Reference Design board) also known as RD-88F6710 board. It is almost
> > entirely similar to the DB-A370 except on the following points:
> > 
> > - second Ethernet MAC is connected to a switch using RGMII
> > - it only has 512MB of physical RAM
> > - SDIO interface is enabled and working by default (no need for jumpers)
> > 
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > ---
> > Jason,
> > 
> > This is rebased against your mvebu/for-next branch, can you please drop v2 of
> > the previous patch and take this one instead? Thanks!
> > 
> > Changes since v2:
> > - rebased against Jason's mvebu/for-next
> > - added SDIO bindings
> > - changed commit message a bit
> > 
> > Changes since v1:
> > - added missing entry in arch/arm/boot/dts/Makefile to actually build the DTB
> > 
> >  arch/arm/boot/dts/Makefile          |    1 +
> >  arch/arm/boot/dts/armada-370-rd.dts |   68 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/armada-370-rd.dts
> 
> Applied to mvebu/dt

oops, I meant mvebu/boards.

thx,

Jason.
