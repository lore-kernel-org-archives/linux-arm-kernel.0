From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 06 Jan 2014 23:55:34 +0100
Subject: [PATCH 2/2] ARM: tegra: paz00: Add LVDS support to device tree
In-Reply-To: <52CB2F59.3060901@wwwdotorg.org>
References: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
 <2030639.dhgZbyhUvO@fb07-iapwap2> <52CB2F59.3060901@wwwdotorg.org>
Message-ID: <1452780.T4ijKNnhdY@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 6. Januar 2014, 15:34:01 schrieb Stephen Warren:
> On 01/06/2014 03:21 PM, Marc Dietrich wrote:
> > Am Montag, 6. Januar 2014, 12:38:20 schrieb Stephen Warren:
> >> On 12/21/2013 01:38 PM, Marc Dietrich wrote:
> >>> Add backlight and panel nodes for the PAZ00 TFT LCD panel.
> >>> 
> >>> Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> >>> ---
> >>> This should enable everything needed. Unfortunately, in my tests it only
> >>> switches on the backlight, but the display controller blocks in some
> >>> infinit loop, so we get no output (and no working system). I post it
> >>> here
> >>> in case I missed something obvious...
> >> 
> >> As mentioned later on, this works fine with U-Boot (and tests fine here
> >> too), so I plan to apply this for 3.15, once I can.
> > 
> > huh? I thought this can go into 3.14 if possible. Patch is harmless and
> > the
> > merge window still weeks away.
> 
> The cut-off for new features was at least a week ago. I expect the merge
> window will open this weekend.

AFAIK, there will be an rc8 (and maybe also an rc9 due to the xmas vacations). 
I submitted the patchset two days after the LVDS support for the other boards 
was sent. Ok, there needs to be some deadline and I may have missed it, but it 
would be really unfortune to miss 3.14 because that's the last missing piece.
