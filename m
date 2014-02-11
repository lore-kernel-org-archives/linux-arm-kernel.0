From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 11 Feb 2014 01:06:43 +0100
Subject: [PATCH v6 01/19] clocksource: orion: Use atomic access for shared
 registers
In-Reply-To: <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52F96993.9090007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 06:20 PM, Ezequiel Garcia wrote:
> Replace the driver-specific thread-safe shared register API
> by the recently introduced atomic_io_clear_set().
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Willy Tarreau <w@1wt.eu>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The patch looks good for me.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
