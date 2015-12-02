From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 1 Dec 2015 20:53:06 -0700
Subject: [PATCH] pinctrl: bcm2835: Fix initial value for direction_output
In-Reply-To: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
References: <1447893147-9458-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <565E6B22.3060808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 05:32 PM, Stefan Wahren wrote:
> Currently the provided initial value for bcm2835_gpio_direction_output
> has no effect. So fix this issue by changing the value before
> changing the GPIO direction. As a result we need to move the function below
> bcm2835_gpio_set.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
