From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 20 Feb 2014 09:39:39 +0100
Subject: [PATCH 2/2] clocksource: armada-370-xp: Use atomic access for
 shared registers
In-Reply-To: <1392840326-29417-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392840326-29417-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392840326-29417-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5305BF4B.5020302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2014 09:05 PM, Ezequiel Garcia wrote:
> Replace the driver-specific thread-safe shared register API
> by the recently introduced atomic_io_clear_set().
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Applied to my tree for 3.15

Thanks !

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
