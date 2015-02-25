From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Feb 2015 16:15:53 +0100
Subject: [PATCH 0/7] New eFuse subsystem
In-Reply-To: <72BC0C8BD7BB6F45988A99382E5FBAE5444505E9@hhmail02.hh.imgtec.org>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
 <20150225120234.GB5062@lukather> <54EDC04E.1050107@imgtec.com>
 <72BC0C8BD7BB6F45988A99382E5FBAE5444505E9@hhmail02.hh.imgtec.org>
Message-ID: <20150225151553.GE5062@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 25, 2015 at 01:12:01PM +0000, James Hartley wrote:
> Hi Maxime, 
> 
> > -----Original Message-----
> > From: Ezequiel Garcia
> > Sent: 25 February 2015 12:30
> > To: Maxime Ripard
> > Cc: Thierry Reding; Stephen Warren; Arnd Bergmann; Andrew Bresticker;
> > James Hartley; linux-arm-kernel at lists.infradead.org; linux-
> > kernel at vger.kernel.org
> > Subject: Re: [PATCH 0/7] New eFuse subsystem
> > 
> > 
> > 
> > On 02/25/2015 09:02 AM, Maxime Ripard wrote:
> > > Hi Ezequiel,
> > >
> > > On Wed, Feb 25, 2015 at 08:45:12AM -0300, Ezequiel Garcia wrote:
> > >> This patchset introduces a new driver subsystem, meant to support
> > >> eFuse (alias OTP, one-time-programmable) devices.
> > >>
> > >> The motivation behind this work is to have a common place for drivers
> > >> that are currently more or less scattered: the tegra efuses are in
> > >> drivers/soc/ and the sunxi efuses in drivers/misc/eeprom.
> > >>
> > >> For now, there's no proposal for a generic efuse API. Instead, we
> > >> simply group the drivers together.
> > >>
> > >> This patchset is the result of the initial submission for IMG
> > >> Pistachio eFuse support [1]. Our first proposal was to follow the
> > >> Tegra efuse, and put the Pistachio efuse in drivers/soc. After some
> > >> discussion we finally agreed [2] to first create an efuse directoy,
> > >> and then put all efuse drivers in it.
> > >>
> > >> As always, all comments are welcome!
> > >>
> > >> [1] http://www.spinics.net/lists/devicetree/msg59246.html
> > >> [2] http://www.spinics.net/lists/arm-kernel/msg389325.html
> > >
> > > Have you looked at the EEPROM framework currently in discussions? The
> > > two seems to be covering pretty much the same use cases.
> > >
> 
> Shouldn't this be a PROM framework if it is going to support both
> EEPROM and EFUSE/QFPROM, or am I missing something here (since an
> eFuse is not eraseable)?

Does it really matter? I mean, it's just a name after all.

But feel free to suggest alternatives on the main thread.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/f30afb44/attachment.sig>
