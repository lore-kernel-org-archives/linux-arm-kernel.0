From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 May 2015 08:46:32 +0900
Subject: [PATCH 1/3] ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN
 for odroidxu3 pmw-fan
In-Reply-To: <1431444262-29531-2-git-send-email-linux.amoon@gmail.com>
References: <linux.amoon@gmail.com>
 <1431444262-29531-1-git-send-email-linux.amoon@gmail.com>
 <1431444262-29531-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <CAJKOXPcXRWm7T29LCYMMkW0FDF8LXEsAoMjwrTqBvSiQ+q5czg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-13 0:24 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
> Enable CONFIG_SENSORS_PWM_FAN on exynos_defconfig to control fan power on Odroidxu3.
>
> ---
> Depends on http://www.spinics.net/lists/arm-kernel/msg412031.html
> Tested on OdroidXU3 Board.
> ---
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

This is mixed up. Try it yourself:
1. Save the email as mbox.
2. Apply with "git am" to a vanilla tree.
Do you see the Signed-off-by in commit?

Best regards,
Krzysztof
