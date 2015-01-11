From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 11 Jan 2015 13:33:27 +0200
Subject: [PATCH v2 0/8] ARM: Conexant Digicolor CX92755 SoC support
In-Reply-To: <5966468.GiJYdzCvnt@wuerfel>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <5966468.GiJYdzCvnt@wuerfel>
Message-ID: <20150111113327.GQ2481@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Jan 08, 2015 at 11:46:46PM +0100, Arnd Bergmann wrote:
> On Thursday 08 January 2015 21:39:56 Baruch Siach wrote:
> > This series adds initial support for the Conexant CX92755 SoC. The CX92755 is
> > one of the Digicolor series of SoCs, all sharing many of the same peripherals.
> > The code was tested on the CX92755 evaluation kit, AKA Equinox.
> > 
> > Uses attempting to try this code will most likely also want the UART/console
> > driver available from https://patchwork.kernel.org/patch/5515861/.
>  
> Looks great overall now.
> 
> I have just two more comments in one patch, and one general request:
> 
> Please add a patch description for every patch. The text above would
> be a good start for the first patch, but it would be lost in the git
> history if it's only in the cover letter.
> 
> other than that, feel free to add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

> Once there are no more review comments, please submit the first three
> patches to arm at kernel.org, and send the other patches as separate
> series to the respective maintainers for irqchip and clocksource.

What about the last patch in this series (ARM: devicetree: document supported 
Conexant Digicolor SoC)? What tree should it go through.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
