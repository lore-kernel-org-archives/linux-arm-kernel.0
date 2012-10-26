From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 20:56:21 +0000
Subject: [PATCH] arm: mvebu: update defconfig with 3.7 changes
In-Reply-To: <9cb693c5-b977-423d-b3a1-569775405bcd@email.android.com>
References: <1350980269-6587-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201210262033.41250.arnd@arndb.de>
 <9cb693c5-b977-423d-b3a1-569775405bcd@email.android.com>
Message-ID: <201210262056.21201.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 October 2012, Jason wrote:
> 
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >On Wednesday 24 October 2012, Thomas Petazzoni wrote:
> >> On Wed, 24 Oct 2012 10:39:42 +0200, Gregory CLEMENT wrote:
> >> > On 10/23/2012 10:17 AM, Thomas Petazzoni wrote:
> >> > > The split of 370 and XP into two Kconfig options and the
> >multiplatform
> >> > > kernel support has changed a few Kconfig symbols, so let's update
> >the
> >> > > mvebu_defconfig file with the latest changes.
> >> > 
> >> > Indeed this patch fixes the mvebu_defconfig which was broken.
> >> > But as now mvebu is part of multi_v7_defconfig, shouldn't we just
> >> > removed mvebu_defconfig ?
> >> 
> >> I think for now, SoC family specific defconfig files are still
> >> accepted, so I'd prefer to keep mvebu_defconfig around. Multiplatform
> >> is nice for users, but I prefer to build a mvebu-only kernel when I'm
> >> doing kernel development.
> >
> >I'd certainly like to see that patch get merged. Should I just apply it
> >to the fixes branch?
> >
> >       Arnd
> 
> Please do.  I have a few other fixes for v3.7 to do this w/e, but iirc they aren't fixing build breakage.
> 

Ok, thanks for the quick reply. Applied now.

	Arnd
