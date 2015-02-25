From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Feb 2015 13:55:12 +0000
Subject: [PATCH 1/2] arm64: juno: Add APB registers and LEDs using syscon
In-Reply-To: <1424866589-2988-1-git-send-email-linus.walleij@linaro.org>
References: <1424866589-2988-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150225135512.GE12377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:16:29PM +0000, Linus Walleij wrote:
> This defines the Juno "APB system registers" as a syscon device,
> and all the LEDs controlled by the APB system registers right
> below it using the syscon LEDs driver on top of syscon. Define
> LED0 for heartbeat, LED1 for MMC0 activity and the following
> four LEDs indicating CPU activity using the Linux-specific
> DT bindings for triggers.
> 
> This is the pattern and same drivers as used on the legacy
> platform device trees for the ARM Integrators and the RealView
> PB1176.

Stupid question, but where are these LEDs located on the platform? I tried
enabling this, but all it seemed to do was make hackbench slightly slower :)

Will
