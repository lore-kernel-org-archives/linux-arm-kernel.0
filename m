From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 7 Nov 2018 11:58:26 -0500 (EST)
Subject: [PATCH 1/2] ARM: copypage-fa: add kto and kfrom to input operands
 list
In-Reply-To: <806401fd406b1391fd3a9f5e072c107a@agner.ch>
References: <20181015221629.13924-1-stefan@agner.ch>
 <CACRpkdaVGKLtE-whhK3oFgY+4xoy1JqWkcBW4UO0-hJs2B-QGg@mail.gmail.com>
 <20181016084416.GF30658@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1810161357580.1498@knanqh.ubzr>
 <fe7595f5d02424c9d92e437cd20361f9@agner.ch>
 <nycvar.YSQ.7.76.1811052231220.1498@knanqh.ubzr>
 <806401fd406b1391fd3a9f5e072c107a@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1811071154590.23219@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Nov 2018, Stefan Agner wrote:

> On 06.11.2018 05:49, Nicolas Pitre wrote:
> > So here's the revised patch. It now has full compile-test coverage for 
> > real this time. Would you mind reviewing it again before I resubmit it 
> > please?
> 
> Compile tested all copypage implementations with the revised patch using
> Clang too, everything builds fine.
> 
> FWIW, I used this defconfigs:
> copypage-fa.c: moxart_defconfig
> copypage-feroceon.c: mvebu_v5_defconfig
> copypage-v4mc.c: h3600_defconfig+CONFIG_AEABI
> copypage-v4wb.c/v4wt.c: multi_v4t_defconfig
> copypage-xsc3.c/scale.c: pxa_defconfig-CONFIG_FTRACE
> 
> The changes look good to me:
> 
> Reviewed-by: Stefan Agner <stefan@agner.ch>

Thanks.  Submitted here:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8805/2


Nicolas
