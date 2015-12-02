From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 2 Dec 2015 15:26:33 +0100
Subject: [PATCH] pinctrl: bcm2835: Fix initial value for direction_output
In-Reply-To: <565E6B22.3060808@wwwdotorg.org>
References: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
 <565E6B22.3060808@wwwdotorg.org>
Message-ID: <565EFF99.7020704@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.12.2015 um 04:53 schrieb Stephen Warren:
> On 11/18/2015 05:32 PM, Stefan Wahren wrote:
>> Currently the provided initial value for bcm2835_gpio_direction_output
>> has no effect. So fix this issue by changing the value before
>> changing the GPIO direction. As a result we need to move the function below
>> bcm2835_gpio_set.
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>

Should i resend the patch with

Suggested-by: Martin Sperl <kernel@martin.sperl.org>

?
