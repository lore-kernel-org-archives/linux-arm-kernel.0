From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Jun 2012 11:50:35 -0400 (EDT)
Subject: [PATCH v2 2/8] arm: mach-mvebu: add source files
In-Reply-To: <4FD73C99.6070908@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <1339433585-28087-3-git-send-email-gregory.clement@free-electrons.com>
 <201206120845.48902.arnd@arndb.de> <4FD73C99.6070908@free-electrons.com>
Message-ID: <alpine.LFD.2.02.1206121143420.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jun 2012, Gregory CLEMENT wrote:

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

Naming SOCs that are not supported yet is bad.

Constantly modifying this title is also unwieldy when it gets long.

Having a comprehensive list of supported SOCs is very useful though, but 
I think this should go in the help text not in the menu title.


Nicolas
