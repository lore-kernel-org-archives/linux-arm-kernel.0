From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 7 Mar 2011 13:17:55 +0100
Subject: [PATCH] ARM: imx: Add tlv320aic32x4 board specific code to
	Visstrim_M10.
In-Reply-To: <20110307121138.GD1829@sirena.org.uk>
References: <1299499439-4466-1-git-send-email-javier.martin@vista-silicon.com>
	<20110307121138.GD1829@sirena.org.uk>
Message-ID: <AANLkTin5eFJYxwByX09atchm+GSEAtu6-9F_bQ-GhS-C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 March 2011 13:11, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Mar 07, 2011 at 01:03:59PM +0100, Javier Martin wrote:
>
>> @@ -30,6 +30,7 @@
>> ?#include <linux/gpio_keys.h>
>> ?#include <linux/input.h>
>> ?#include <linux/gpio.h>
>> +#include <sound/tlv320aic32x4.h>
>> ?#include <asm/mach-types.h>
>> ?#include <asm/mach/arch.h>
>> ?#include <asm/mach/time.h>
>
> Note that this only just got merged into -next so won't build in the ARM
> tree until after the merge window.
>

OK, sorry for that.
Sascha please, discard the patch. I will send it again after the next
merge window.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
