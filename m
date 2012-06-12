From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 13:35:29 +0000
Subject: [PATCH v2 2/8] arm: mach-mvebu: add source files
In-Reply-To: <4FD73C99.6070908@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <201206120845.48902.arnd@arndb.de> <4FD73C99.6070908@free-electrons.com>
Message-ID: <201206121335.29298.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 June 2012, Gregory CLEMENT wrote:
> On 06/12/2012 10:45 AM, Arnd Bergmann wrote:
> > On Monday 11 June 2012, Gregory CLEMENT wrote:
> >> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> >> new file mode 100644
> >> index 0000000..72d39e5
> >> --- /dev/null
> >> +++ b/arch/arm/mach-mvebu/Kconfig
> >> @@ -0,0 +1,7 @@
> >> +if ARCH_MVEBU
> >> +
> >> +menu "Marvell SOC with device tree"
> >> +
> >> +endmenu
> >> +
> >> +endif
> >
> > The "with device tree" part is implied here, so you should not need to
> > mention it, but it would be good if you could say which SOC this
> > relates to, i.e. not the pxa/mmp series but the other line, in whatever
> > way you want to name it.
> 
> Do you mean to name all the SOC aimed to be supported ?
> and write something like that:
> 
> menu "Marvell SOC from EBU division (Orion, Kirkwood, Dove, MV78xx0,
> Armada 370/XP, ...)"
> 
> Or for now just the currently supported SOC ? :
> menu "Marvell SOC from EBU division (Armada 370, Armada XP, ...)"

Either way is fine for me.

> OK I will drop common.* files. We will see later to introduce them
> again when we find common features with the other SOC.

Ok. We might just name them after the specific feature that gets
implemented then.

	Arnd
