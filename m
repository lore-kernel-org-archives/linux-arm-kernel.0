From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 14 Feb 2018 12:56:53 +0200
Subject: [PATCH v2 1/2] arm64: dts: marvell: add CP110 uart peripherals
In-Reply-To: <87vaezonrn.fsf@bootlin.com>
References: <03f1bec6e11c9f6fb9d5520c745eafca28597801.1517381798.git.baruch@tkos.co.il>
 <87vaezonrn.fsf@bootlin.com>
Message-ID: <20180214105653.r4hcdxgbdmth3d7a@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Wed, Feb 14, 2018 at 11:42:52AM +0100, Gregory CLEMENT wrote:
>  On mer., janv. 31 2018, Baruch Siach <baruch@tkos.co.il> wrote:
> 
> > The CP110 component has 4 uart peripherals. All of them use the same clock
> > gate for slow peripherals that is shared with the i2c and spi peripherals.
> >
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> Applied on mvebu/dt64

Thanks.

What about patch 2/2 in this series?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
