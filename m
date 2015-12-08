From: hadess@hadess.net (Bastien Nocera)
Date: Tue, 08 Dec 2015 13:14:58 +0100
Subject: [PATCH 2/2] input: gt801_2plus1 - Add initial support for
 Goodix GT801 2+1
In-Reply-To: <1449473161-3535-3-git-send-email-plaes@plaes.org>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
 <1449473161-3535-3-git-send-email-plaes@plaes.org>
Message-ID: <1449576898.28364.16.camel@hadess.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Priit,

On Mon, 2015-12-07 at 09:26 +0200, Priit Laes wrote:
> This patch adds Goodix GT801 2+1 touchscreen controller support.
> 
> GT801 2+1 is a 10-finger touch controller consisting of
> ARM controller interfacing two GT801 5-finger controllers.

This would implement support for the "Guitar" protocol used by a few
more variants of the GT80x devices. Can you rename the driver/docs to that effect?
<snip>
> +
> +static const struct i2c_device_id gt801x_ts_id[] = {
> +	{ "GDIX1001:00", 0 },

This clashes with the ID used in the goodix.c driver.

Cheers
