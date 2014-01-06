From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 06 Jan 2014 23:21:30 +0100
Subject: [PATCH 2/2] ARM: tegra: paz00: Add LVDS support to device tree
In-Reply-To: <52CB062C.50802@wwwdotorg.org>
References: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
 <bcf12ecec69ef4e38e74a9be9c45e8bd2bd9ffcc.1387656959.git.marvin24@gmx.de>
 <52CB062C.50802@wwwdotorg.org>
Message-ID: <2030639.dhgZbyhUvO@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 6. Januar 2014, 12:38:20 schrieb Stephen Warren:
> On 12/21/2013 01:38 PM, Marc Dietrich wrote:
> > Add backlight and panel nodes for the PAZ00 TFT LCD panel.
> > 
> > Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> > ---
> > This should enable everything needed. Unfortunately, in my tests it only
> > switches on the backlight, but the display controller blocks in some
> > infinit loop, so we get no output (and no working system). I post it here
> > in case I missed something obvious...
> As mentioned later on, this works fine with U-Boot (and tests fine here
> too), so I plan to apply this for 3.15, once I can.

huh? I thought this can go into 3.14 if possible. Patch is harmless and the 
merge window still weeks away.
