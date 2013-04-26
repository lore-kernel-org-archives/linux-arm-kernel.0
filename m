From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 26 Apr 2013 09:21:36 +0200
Subject: linux-next: manual merge of the arm-soc tree with the spi-mb tree
In-Reply-To: <20130426170649.d21c2d7a74e56d836ff6f04f@canb.auug.org.au>
References: <20130426170649.d21c2d7a74e56d836ff6f04f@canb.auug.org.au>
Message-ID: <CACQ1gAidYqDm_SHea9jQFGqernZpgT8RuaRSP2N0ZPUX7JYyrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/4/26 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/boot/dts/at91sam9x5.dtsi between commits d50f88a0c304 ("ARM:
> dts: add spi nodes for atmel SoC") and a68b728f7a21 ("ARM: dts: add
> pinctrl property for spi node for atmel SoC") from the spi-mb tree and
> commits e9a72ee81d58 ("ARM: at91: dt: at91sam9x5: add i2c pinctrl"),
> 463c9c7bf1f3 ("ARM: at91: dt: at91sam9x5: add i2c-gpio pinctrl") and
> b909c6c94462 ("ARM: at91/at91sam9x5: add RTC node") from the arm-soc tree.
>
> I fixed it up (hopefully - see below) and can carry the fix as necessary
> (no action is required).

Hi,

It's all ok for me !

Thanks,

Richard.
