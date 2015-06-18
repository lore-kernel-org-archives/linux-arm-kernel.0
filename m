From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 18 Jun 2015 13:09:46 +0200
Subject: [PATCH 36/41] clocksource: stm32: Migrate to new 'set-state'
 interface
In-Reply-To: <7fc5a0bfae6062b7fbea71a9a469e6574a1c3cf6.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <7fc5a0bfae6062b7fbea71a9a469e6574a1c3cf6.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <5582A6FA.4040108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On 06/18/2015 12:54 PM, Viresh Kumar wrote:
> Migrate stm32 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
>
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/clocksource/timer-stm32.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
>
>

Thanks for having implemented the move to the new interface.
I just tested it, and confirm it works fine on my STM32 board.
You can add:

Tested-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Regards,
Maxime
