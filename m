From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 Dec 2011 15:14:08 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c
In-Reply-To: <4EFC0AE4.6020608@googlemail.com>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <4EFC0AE4.6020608@googlemail.com>
Message-ID: <20111229071407.GA11474@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 07:38:28AM +0100, Dirk Behme wrote:
> On 06.12.2011 11:27, Lothar Wa?mann wrote:
> >The following set of patches provides some cleanup and bugfixes for
> >drivers/net/ethernet/freescale/fec.c and makes the driver buildable as
> >a module.
> >
> >Lothar Wa??mann (8):
> >   misc cleanups
> >   set con_id in clk_get() call to NULL
> >   prevent dobule restart of interface on FDX/HDX change
> >   don't request invalid IRQ
> >   don't munge MAC address from platform data
> >   preserve MII/RMII setting in fec_stop()
> >   fix the .remove code
> >   make FEC driver buildable as module
> >
> >  drivers/net/ethernet/freescale/Kconfig |    2 +-
> >  drivers/net/ethernet/freescale/fec.c   |   63 ++++++++++++++++++++++----------
> >  2 files changed, 44 insertions(+), 21 deletions(-)
> 
> What's the status of this patch series?
> 
> If I remember correctly, most of them got an Ack or Tested-by from
> Shawn? But one or two need an update (not sure, though)? And the
> subject should be updated?
> 
The series with update has been picked up by David on net-next.
The LAKML was just missed from the updated posting.

-- 
Regards,
Shawn
