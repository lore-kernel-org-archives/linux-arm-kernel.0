From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jan 2017 08:16:15 +0000
Subject: linux-next: manual merge of the mfd tree with the arm-soc tree
In-Reply-To: <20170124134319.2a6ba85d@canb.auug.org.au>
References: <20170124134319.2a6ba85d@canb.auug.org.au>
Message-ID: <20170124081615.GQ16020@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jan 2017, Stephen Rothwell wrote:

> Hi all,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>   arch/arm/boot/dts/stm32f429.dtsi
> 
> between commits:
> 
>   3604ef9c8154 ("ARM: dts: stm32: Add ADC support to stm32f429")
>   dd3feb755a4a ("ARM: dts: stm32: Add RTC support for STM32F429 MCU")
> 
> from the arm-soc tree and commit:
> 
>   9072b6b2ba83 ("ARM: dts: stm32: add Timers driver for stm32f429 MCU")
> 
> from the mfd tree.

An immutable branch as already been posted for this.

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
