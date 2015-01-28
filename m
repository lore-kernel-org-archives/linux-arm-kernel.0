From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 29 Jan 2015 00:41:45 +0200
Subject: [PATCH v2 0/8] ARM: Conexant Digicolor CX92755 SoC support
In-Reply-To: <1422484395.3621.73.camel@x220>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <5966468.GiJYdzCvnt@wuerfel> <1422484395.3621.73.camel@x220>
Message-ID: <20150128224145.GK3148@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, Jan 28, 2015 at 11:33:15PM +0100, Paul Bolle wrote:
> On Thu, 2015-01-08 at 23:46 +0100, Arnd Bergmann wrote:
> > Once there are no more review comments, please submit the first three
> > patches to arm at kernel.org, and send the other patches as separate
> > series to the respective maintainers for irqchip and clocksource.
> 
> I found this message while looking into CONFIG_ARCH_DIGICOLOR. That
> Kconfig macro entered linux-next in next-20150128. But there's no
> Kconfig symbol ARCH_DIGICOLOR yet in linux-next.

Just for the record: base digicolor platform support is in the for-next branch 
of arm-soc.git since today. I guess it should appear in linux-next tomorrow.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
