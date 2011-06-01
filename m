From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Jun 2011 11:37:40 -0700
Subject: [PATCH 1/3] ARM: pmu: add OF probing support
In-Reply-To: <1306946270-18379-2-git-send-email-robherring2@gmail.com>
References: <1306946270-18379-1-git-send-email-robherring2@gmail.com>
	<1306946270-18379-2-git-send-email-robherring2@gmail.com>
Message-ID: <BANLkTikim3zwsvFK_UVqGmkyxRmfZETUsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 9:37 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Add OF match table to enable OF style driver binding. The dts entry is like
> this:
>
> pmu {
> ? ? ? ?compatible = "arm,cortex-a9-pmu";
> ? ? ? ?interrupts = <100 101>;
> };
>
> The use of pdev->id as an index breaks with OF device binding, so set the type
> based on the OF compatible string.

Even though they're simple, new bindings like these need to be
documented. Current location for that is
Documentation/devicetree/bindings/.

Can you start an ARM directory there and add corresponding docs for the this?


Thanks!

-Olof
