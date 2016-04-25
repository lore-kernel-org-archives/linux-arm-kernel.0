From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 25 Apr 2016 16:37:59 +0200
Subject: [PATCH 0/2] Support MPS2 Timer
In-Reply-To: <1461573944-2728-1-git-send-email-vladimir.murzin@arm.com>
References: <1461573944-2728-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160425143759.GD3974@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 09:45:42AM +0100, Vladimir Murzin wrote:
> Hi,
> 
> These patches allow to use simple 32 bits general purpose countdown
> timers found on MPS2 platform.
> 
> Following [1], please, consider to merge them into clocksource tree.
> 
> [1] https://lkml.org/lkml/2016/4/23/190
> 
> Thanks!
> 
> Vladimir Murzin (2):
>   dt-bindings: document the MPS2 timer bindings
>   clockevents/drivers: add MPS2 Timer driver
> 
>  .../devicetree/bindings/timer/arm,mps2-timer.txt   |   28 ++
>  drivers/clocksource/Kconfig                        |    6 +
>  drivers/clocksource/Makefile                       |    1 +
>  drivers/clocksource/mps2-timer.c                   |  275 ++++++++++++++++++++
>  4 files changed, 310 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/arm,mps2-timer.txt
>  create mode 100644 drivers/clocksource/mps2-timer.c

Applied for 4.7.

Thanks !

  -- Daniel
