From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 23 Jul 2012 14:48:20 +0100
Subject: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
In-Reply-To: <20120723133400.GU4435@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
 <20120723133400.GU4435@opensource.wolfsonmicro.com>
Message-ID: <500D5624.4010505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/12 14:34, Mark Brown wrote:
> On Mon, Jul 23, 2012 at 01:23:50PM +0000, AnilKumar, Chimata wrote:
>
>> By the way, if we look at all the regulator added (DT supported) till now have
>> the similar problem.
>
>> arch/arm/boot/dts/imx6q.dtsi
>
> This is fine - the SoC contains integrated regulators which supply other
> bits of the Soc so we can be confident that the hookup is good just
> based on the silicon.
>
>> arch/arm/boot/dts/twl4030.dtsi
>> arch/arm/boot/dts/twl6030.dtsi
>
> These appear to have similar issues and should be fixed, at least as far
> as the voltage ranges go.
>
>> arch/arm/boot/dts/db8500.dtsi
>
> I'm not actually seeing anything terribly problematic here, though the
> regulator-name properties should really be removed as they're fairly
> useless and seem to be missing the point of having the property.

I've missed the context of the thread, so can't comment, but I'm happy 
to remove the regulator-name properties from db8500.dts. Adding to my TODO.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
