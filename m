From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Oct 2010 01:49:53 -0700
Subject: [PATCH 1/2] S3C64XX: Ensure samsung_keypad_cfg_gpio() is
	prototyped
In-Reply-To: <003101cb6ab3$753ca4f0$5fb5eed0$%kim@samsung.com>
References: <1286904195-1534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<002701cb6aae$af084680$0d18d380$%kim@samsung.com>
	<20101013081954.GC6424@rakim.wolfsonmicro.main>
	<003101cb6ab3$753ca4f0$5fb5eed0$%kim@samsung.com>
Message-ID: <20101013084952.GB29239@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 05:48:48PM +0900, Kukjin Kim wrote:

> You mean following?
> arch/arm/mach-s3c64xx/setup-keypad.c:16:6: warning: symbol
> 'samsung_keypad_cfg_gpio' was not declared. Should it be static?

Yup, that's the one.

> I didn't check sparse :-(
> Ok...Ben seems to be busy now...so will apply in my tree.
> And I will also fix it our Samsung stuff.

Thanks!
