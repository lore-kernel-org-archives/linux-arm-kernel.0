From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 21 Jul 2014 11:14:09 +0200
Subject: [PATCH v2 00/14] AT91: PIT: Cleanups and move to
 drivers/clocksource
In-Reply-To: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404207208-14513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53CCD9E1.9000402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 11:33 AM, Maxime Ripard wrote:
> Hi everyone,
>
> This series cleans up the PIT driver in order for it to not depend on
> anything in mach-at91 anymore, and in the end move it out of
> mach-at91.
>
> Along the way, these patches also do a bit of cleanup.
>
> This has been tested on a G45-EK without DT and an Xplained with DT.

For the entire serie:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
