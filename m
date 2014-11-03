From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 17:51:05 +0100
Subject: [PATCH v2 3/4] clocksource: armada-370-xp: Use the reference
 clock on A375 SoC
In-Reply-To: <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5457B279.5060106@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 25/10/2014 16:48, Ezequiel Garcia wrote:
> The 25 MHz reference clock has better stability so its use is preferred over the
> core clock.
> 
> This commit takes advantage of the already introduced Armada 375 devicetree
> compatible string and adds a new timer initialization. If available, the timer
> will use the reference clock (named as 'fixed'). Otherwise, it falls back to the
> previous behavior.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 ++++---
>  drivers/clocksource/time-armada-370-xp.c           | 28 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
