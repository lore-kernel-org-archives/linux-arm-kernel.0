From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 29 Feb 2012 14:53:05 +0200
Subject: iMX53 quick start board and SD/MMC
In-Reply-To: <4F4E1E00.6070406@linuxtv.org>
References: <4F4E119D.7020104@linuxtv.org>
 <20120229122217.GC4649@sapphire.tkos.co.il>
 <4F4E1E00.6070406@linuxtv.org>
Message-ID: <20120229125305.GD4649@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael

On Wed, Feb 29, 2012 at 01:45:52PM +0100, Michael Hunold wrote:
> on 29.02.2012 13:22 Baruch Siach said the following:
> > You should probably consider using imx_v6_v7_defconfig, since i.MX53 is based 
> > on ARMv7.
> 
> thank you very much. That was a hint in the right direction.
> 
> I had to choose "mx5_defconfig" instead.

Note that mx5_defconfig is removed since commit 3f07f3557 (ARM i.MX: Update 
defconfig), which is present in v3.3-rc2.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
