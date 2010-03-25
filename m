From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 25 Mar 2010 18:41:47 +0200
Subject: [BUG] i.MX25: Broken include in mach-mx25pdk.c
In-Reply-To: <20100325161635.GI2328@darwin>
References: <20100325161635.GI2328@darwin>
Message-ID: <20100325164147.GA27698@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Thu, Mar 25, 2010 at 05:16:35PM +0100, Matthias Kaehlcke wrote:
> compiling arch/arm/mach-mx25/mach-mx25pdk.c fails due to the missing
> include "linux/fec.h" and incomplete types that are supposed to
> defined in this header
> 
> i'd send a fix, but greping through the kernel tree i haven't been
> able to identify the file defining the missing elements, i suppose it's still
> sitting bored in some development tree waiting to be merged

Apply the patch at http://patchwork.ozlabs.org/patch/41235/.

For some reason this patch never made it to the mainline even after my 
repeated nagging :(.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
