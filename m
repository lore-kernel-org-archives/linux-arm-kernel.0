From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Jun 2014 12:21:36 +0200
Subject: [PATCH 0/6] ARM: at91: more clocks fixes for 3.16
In-Reply-To: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53AAA2B0.1070103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2014 18:41, Alexandre Belloni :
> Hi,
> 
> This patch set fixes more issues with the clocks on AT91:
> 
> The first patch define the slow crystal on the at91sam9261ek board
> 
> The next patchs are moving all the clocks that were under the root under a
> "clocks" node to be consistent accross all architecture.
> 
> Alexandre Belloni (6):
>   ARM: at91/dt: define sam9261ek slow crystal frequency
>   ARM: at91/dt: sam9261 crystals under the clocks node
>   ARM: at91/dt: sam9n12 crystals under the clocks node
>   ARM: at91/dt: sam9rl crystals under the clocks node
>   ARM: at91/dt: sam9x5 crystals under the clocks node
>   ARM: at91/dt: sama5d3 crystals under the clocks node

On the whole series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
And stacked on 3.16-fixes branch.

Best regards,


>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 12 +++++++-----
>  arch/arm/boot/dts/at91sam9261.dtsi          | 20 ++++++++++---------
>  arch/arm/boot/dts/at91sam9261ek.dts         | 12 ++++++++----
>  arch/arm/boot/dts/at91sam9n12.dtsi          | 20 ++++++++++---------
>  arch/arm/boot/dts/at91sam9n12ek.dts         | 16 +++++++--------
>  arch/arm/boot/dts/at91sam9rl.dtsi           | 22 ++++++++++-----------
>  arch/arm/boot/dts/at91sam9rlek.dts          | 17 ++++++++--------
>  arch/arm/boot/dts/at91sam9x5.dtsi           | 30 +++++++++++++++--------------
>  arch/arm/boot/dts/at91sam9x5cm.dtsi         | 12 +++++++-----
>  arch/arm/boot/dts/sama5d3.dtsi              | 22 ++++++++++-----------
>  arch/arm/boot/dts/sama5d3xcm.dtsi           | 12 +++++++-----
>  11 files changed, 105 insertions(+), 90 deletions(-)
> 


-- 
Nicolas Ferre
