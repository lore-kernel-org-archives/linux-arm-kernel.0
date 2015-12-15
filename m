From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 15 Dec 2015 18:59:31 +0100 (CET)
Subject: [PATCH 0/3] pwm: bcm2835: improve clock handling
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <2004478620.33734.6de503e6-02cb-4cce-af2d-c2614efc234a.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Stefan Wahren <stefan.wahren@i2se.com> hat am 1. Dezember 2015 um 23:55
> geschrieben:
>
>
> With the upcoming PWM clock support the pwm-bcm2835 should take
> more care about the clock handling. But this patch series doesn't
> depend on these clock driver changes.
>
> Stefan Wahren (3):
> pwm: bcm2835: calculate scaler in pwm_config
> pwm: bcm2835: prevent division by zero
> pwm: bcm2835: fix email address specifiction
>
> drivers/pwm/pwm-bcm2835.c | 18 ++++++++++++------
> 1 file changed, 12 insertions(+), 6 deletions(-)
>

gently ping
