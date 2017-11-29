From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 22:39:47 +0800
Subject: [PATCH] ARM: dts: imx6qdl-udoo: add support for powering off
In-Reply-To: <475cb655-a88f-0cc2-2e00-405458f80433@maciej.szmigiero.name>
References: <475cb655-a88f-0cc2-2e00-405458f80433@maciej.szmigiero.name>
Message-ID: <20171129143946.GO9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 11:22:28PM +0100, Maciej S. Szmigiero wrote:
> UDOO board has a possibility to disable most of imx6 SoC power supplies via
> "EN_5V" signal, which is connected to "NANDF_D4" pad.
> 
> This reduces current consumption after shutdown from ~350 mA to ~40 mA and
> prevents a SoC watchdog from starting it again on its own after the
> watchdog timeout expires (previously it was not possible to shut down the
> SoC permanently if its watchdog was ever enabled since it was still ticking
> after the shutdown).
> 
> Unfortunately, this does not extinguish the "Power" LED (as it is powered
> from an always-on voltage regulator).
> 
> To power the SoC up again press the power button (SW2, the one with a long
> shaft).
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Applied, thanks.
