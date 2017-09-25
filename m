From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 Sep 2017 22:13:31 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: Add charger node
In-Reply-To: <20170815062420.21644-1-wenyou.yang@microchip.com>
References: <20170815062420.21644-1-wenyou.yang@microchip.com>
Message-ID: <20170925201331.4qzewq3rahtrynt7@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/2017 at 14:24:20 +0800, Wenyou Yang wrote:
> From: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Add the charger device node as a sub-device of act8945a mfd, move
> the charger's properties in the node, and replace the
> "active-semi,irq_gpios" with the "interrupts" property to denote
> the act8945a charger's irq.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
> ---
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Applied, now but I had to rework the patch a bit. Can you check this is
working for you?

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=at91-dt&id=4b6ad41f267b8ddabf5dd1b02a318bc74f0b95e9

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
