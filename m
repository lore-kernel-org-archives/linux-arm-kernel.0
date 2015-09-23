From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 23 Sep 2015 05:16:38 -0700
Subject: [PATCH 6/6] ARM: dts: set up trigger type for edt-ft5x06
 interrupts
In-Reply-To: <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
 <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
Message-ID: <20150923121637.GG3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2015 at 10:45:51AM -0700, Dmitry Torokhov wrote:
> Now that the driver respects IRQ trigger settings from device tree, let's
> fix them up in individual DTSes (note that the driver is still compatible
> with older DTSes).
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
...
>  arch/arm/boot/dts/imx28-tx28.dts      | 3 ++-
>  arch/arm/boot/dts/imx53-tx53-x03x.dts | 3 ++-
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi    | 3 ++-

Acked-by: Shawn Guo <shawnguo@kernel.org>
