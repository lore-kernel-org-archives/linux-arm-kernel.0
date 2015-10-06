From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Tue, 6 Oct 2015 08:52:43 +0200
Subject: [PATCH 06/17] ARM: pxa: magician: Use PWM lookup table
In-Reply-To: <1444034997-9805-7-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
 <1444034997-9805-7-git-send-email-thierry.reding@gmail.com>
Message-ID: <CA+gwMccw3oAT6vyKfVcqAHsf532bqpCvT5Kp_2c1=1r7FP_JMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 5, 2015 at 10:49 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Use a PWM lookup table to provide the PWM to the pwm-backlight device.
> The driver has a legacy code path that is required only because boards
> still use the legacy method of requesting PWMs by global ID. Replacing
> these usages allows that legacy fallback to be removed.
>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
