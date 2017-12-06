From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 6 Dec 2017 08:01:32 +0100
Subject: [PATCH] ARM: dts: introduce the sama5d2 ptc ek board
In-Reply-To: <20171205170141.qleqh6rou2ow54je@tarshish.tkos.co.il>
References: <20171205142312.21506-1-ludovic.desroches@microchip.com>
 <20171205170141.qleqh6rou2ow54je@tarshish.tkos.co.il>
Message-ID: <20171206070132.GE2451@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 07:01:41PM +0200, Baruch Siach wrote:
> Hi Ludovic,
> 
> On Tue, Dec 05, 2017 at 03:23:12PM +0100, Ludovic Desroches wrote:
> > Add the official SAMA5D2 Peripheral Touch Controller Evaluation
> > Kit board.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > ---
> 
> [...]
> 
> > +	memory {
> > +		reg = <0x20000000 0x80000>;
> > +	};
> 
> The size value is clearly wrong; you surely don't run on 512KB RAM. You most 
> likely rely on the bootloader to fix the size value. Since sama5d2.dtsi has a 
> memory node already with the same address, you can just drop it from here.
> 

Thanks, fixed in v2.

Ludovic

> baruch
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
