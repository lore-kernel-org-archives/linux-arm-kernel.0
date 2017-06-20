From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 17:34:57 +0200
Subject: [PATCH 0/6] Update binding documentation for cp110 and ap806
In-Reply-To: <20170620083754.28053-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Tue, 20 Jun 2017 10:37:47 +0200")
References: <20170620083754.28053-1-gregory.clement@free-electrons.com>
Message-ID: <87k2463c66.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, 
 
 On mar., juin 20 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Rob,
>
> As you know there were dependencies issue about the binding between my
> different series and you proposed yourself to apply them though the
> device tree subsystem: [1]
>
> All the driver parts have been merged so it's time merging the
> documentation.

I forgot to mentioned that this series is based on the clk-ap806-dt
stable branch:

https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806-dt

Gregory

>
> Thanks,
>
> Gregory
>
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/509643.html
>
> Gregory CLEMENT (6):
>   dt-bindings: cp110: do not depend anymore of the *-clock-output-names
>   dt-bindings: cp110: introduce a new binding
>   dt-bindings: cp110: add sdio clock to cp-110 system controller
>   pinctrl: dt-bindings: add documentation for AP806 pin controllers
>   pinctrl: dt-bindings: add documentation for CP110 pin controllers
>   gpio: dt-bindings: Add documentation for gpio controllers on Armada
>     7K/8K
>
>  .../arm/marvell/ap806-system-controller.txt        |  73 ++++++++++-
>  .../arm/marvell/cp110-system-controller0.txt       | 144 ++++++++++++++++++---
>  .../devicetree/bindings/gpio/gpio-mvebu.txt        |  24 +++-
>  3 files changed, 208 insertions(+), 33 deletions(-)
>
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
