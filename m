From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Mar 2016 08:15:16 -0600
Subject: [PATCH] pinctrl: bcm2835: Implement get_direction callback
In-Reply-To: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
References: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <56FBDF74.3040400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2016 08:58 AM, Stefan Wahren wrote:
> Implement gpio_chip's get_direction() callback, that lets other
> drivers get particular GPIOs direction using gpiod_get_direction().

Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
