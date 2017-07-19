From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 19 Jul 2017 06:56:51 +0300
Subject: [PATCH] irqchip: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-30-robh@kernel.org>
References: <20170718214339.7774-30-robh@kernel.org>
Message-ID: <20170719035651.32e4ium6bymztlqj@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jul 18, 2017 at 04:43:10PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S?ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-tegra at vger.kernel.org
> ---

>  drivers/irqchip/irq-digicolor.c          |  8 ++++----

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
