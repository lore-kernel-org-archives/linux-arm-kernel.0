From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 11:39:30 -0600
Subject: [RFT v2 04/10] pinctrl: samsung: Add dedicated compatible for
 S5Pv210 wakeup interrupts
In-Reply-To: <20180723175302.22535-5-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
 <20180723175302.22535-5-krzk@kernel.org>
Message-ID: <20180725173930.GA27860@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 07:52:56PM +0200, Krzysztof Kozlowski wrote:
> The S5Pv210 external wakeup interrupts differ from Exynos therefore
> separate compatible is needed.  Duplicate existing flavor specific data
> from exynos4210_wkup_irq_chip and add new compatible for S5Pv210.
> At this point this new compatible does not bring anything new and works
> exactly as existing "samsung,exynos4210-wakeup-eint".
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <snawrocki@kernel.org>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/samsung-pinctrl.txt    |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/samsung/pinctrl-exynos.c               | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
