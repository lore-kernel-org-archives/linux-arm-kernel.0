From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 29 Feb 2012 14:22:17 +0200
Subject: iMX53 quick start board and SD/MMC
In-Reply-To: <4F4E119D.7020104@linuxtv.org>
References: <4F4E119D.7020104@linuxtv.org>
Message-ID: <20120229122217.GC4649@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Wed, Feb 29, 2012 at 12:53:01PM +0100, Michael Hunold wrote:
> I am trying to setup a iMX53 quick start board. This is my first
> encounter with Freescale, so please bear with me.
> 
> I used the Code Sourcery arm-2011.03 toolchain and a stock Linux 3.2.8
> kernel. I used "imx_v4_v5_defconfig" and selected support for the "LOCO"
> board, nothing more.

You should probably consider using imx_v6_v7_defconfig, since i.MX53 is based 
on ARMv7.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
