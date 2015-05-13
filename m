From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 13:13:01 +0900
Subject: [PATCHv2 3/3] ARM: exynos_defconfig: Enable LEDs for odroidxu3.
In-Reply-To: <1431489174-4479-4-git-send-email-linux.amoon@gmail.com>
References: <1431489174-4479-1-git-send-email-linux.amoon@gmail.com>
 <1431489174-4479-4-git-send-email-linux.amoon@gmail.com>
Message-ID: <5552CF4D.1060007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.05.2015 12:52, Anand Moon wrote:
> Enable CONFIG_LEDS_GPIO, CONFIG_LEDS_TRIGGERS, CONFIG_LEDS_TRIGGER_HEARTBEAT.

1. Remove the trailing stop (dot) from commit title.
2. Please go back to default length of wrapping commit messages. This
one exceeds it. Default is 75 characters so git log or git show output
would fit in 80 characters terminal.
3. It would be nice to see here WHY you are enabling these configs (what
is the benefit). One sentence would be enough.

With these changes you can add my tag:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
