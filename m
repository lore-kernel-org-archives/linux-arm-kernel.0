From: marex@denx.de (Marek Vasut)
Date: Fri, 21 Dec 2012 03:03:20 +0100
Subject: [PATCH 0/8] arm: mxs: Various mxs_defconfig adjustments
In-Reply-To: <CAAQ0ZWSxdfWzaHfr2eVazRHp-eGBdHFyVb-P_ib_6xmoGWXQdw@mail.gmail.com>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
 <201212201344.27626.marex@denx.de>
 <CAAQ0ZWSxdfWzaHfr2eVazRHp-eGBdHFyVb-P_ib_6xmoGWXQdw@mail.gmail.com>
Message-ID: <201212210303.20834.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Thu, Dec 20, 2012 at 01:44:27PM +0100, Marek Vasut wrote:
> > Dear Shawn Guo,
> > 
> > > On Wed, Dec 19, 2012 at 06:32:58PM +0100, Marek Vasut wrote:
> > > > This patchset enables various config options, mostly needed to
> > > > get MX28EVK and M28EVK decently working.
> > > > 
> > > > Marek Vasut (8):
> > > >   arm: mxs: Regenerate mxs_defconfig to match recent kernel
> > > >   arm: mxs: Enable MTD block access
> > > >   arm: mxs: Enable UBI and UBIFS
> > > >   arm: mxs: Enable JFFS2
> > > >   arm: mxs: Enable EXT2 and EXT4
> > > >   arm: mxs: Enable AT24 EEPROM support
> > > >   arm: mxs: Enable support for most SPI flashes
> > > >   arm: mxs: Enable most commonly used PHYs
> > > 
> > > It does not need to be so verbose.  It can just be one patch.
> > 
> > Do you prefer one gigantic patch then?
> 
> I do not take "1 file changed, 30 insertions(+), 33 deletions(-)" as
> a gigantic change set, especially when it's on defconfig.  Just remember
> to run savedefconfig before you submit the changes.

Sure, one big nasty patch on it's way to your mailbox then.

I wanted to keep the changes separate to make them obvious and clear, that was 
my whole motivation, nothing else.

[...]

Best regards,
Marek Vasut
