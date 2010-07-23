From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 23 Jul 2010 17:18:33 +0400
Subject: [PATCH v5 3/4] Add s3c-adc-battery driver
In-Reply-To: <1279364224-24525-4-git-send-email-anarsoul@gmail.com>
References: <1279364224-24525-1-git-send-email-anarsoul@gmail.com>
	<1279364224-24525-4-git-send-email-anarsoul@gmail.com>
Message-ID: <20100723131833.GA14980@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 17, 2010 at 01:57:03PM +0300, Vasily Khoruzhick wrote:
> s3c-adc-battery is driver for monitoring
> and charging battery on iPAQ H1930/H1940/RX1950.
> It depends on s3c-adc driver to get battery voltage and current.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---

Applied to battery-2.6.git (for -next) with a few cosmetic
fixes.

If/when Ben comment on this driver, feel free to send fixups
on top of battery-2.6.git.

Also, I can take patch 4/4 if Ben ack it.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
