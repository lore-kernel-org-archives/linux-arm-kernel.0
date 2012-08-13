From: marex@denx.de (Marek Vasut)
Date: Mon, 13 Aug 2012 17:18:14 +0200
Subject: [PATCH 1/2] ARM: mach-imx: Remove board entries in dt_board_compat
In-Reply-To: <20120813151509.GB27393@S2101-09.ap.freescale.net>
References: <1339941856-2836-1-git-send-email-festevam@gmail.com>
 <20120705074623.GG10610@S2101-09.ap.freescale.net>
 <20120813151509.GB27393@S2101-09.ap.freescale.net>
Message-ID: <201208131718.14546.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Thu, Jul 05, 2012 at 03:46:23PM +0800, Shawn Guo wrote:
> > On Thu, Jul 05, 2012 at 09:13:18AM +0200, Sascha Hauer wrote:
> > > Shawn,
> > > 
> > > Is this ok with you?
> > 
> > No.
> > 
> > http://thread.gmane.org/gmane.linux.ports.arm.kernel/172558/focus=172703
> 
> I change my mind.  Though it's really a pity to lose a concentrated
> place maintaining a full list of compatible strings of all supported
> board, I'm more concerned by the dt_board_compat matching efficiency
> when the table gets longer.
> 
> So, Fabio, can you please resend the patches against v3.6-rc?

What about the board quirks that are present there?

Best regards,
Marek Vasut
