From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Oct 2010 20:42:57 +0100
Subject: [PATCH 2.6.36] S3C64XX: Fix special function for IISv4 port
In-Reply-To: <1286998603-20401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1286998603-20401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20101013194256.GA20533@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 08:36:43PM +0100, Mark Brown wrote:
> When converting to use s3c_gpio_cfgpin_range() the function for the
> IISv4 block appears to have been typoed as 4 (the keypad) rather than
> 5 as it should be.

Sorry about the 2.6.36 in the subject line - this actually only applies
to -next.
