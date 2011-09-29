From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 17:30:48 +0100
Subject: [PATCH 5/5] ARM: pxa: move gpio driver into drivers directory
In-Reply-To: <1317309546-19682-5-git-send-email-haojian.zhuang@marvell.com>
References: <2011092901>
	<1317309546-19682-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110929163048.GA21718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 11:19:06PM +0800, Haojian Zhuang wrote:
> +#include <linux/gpio-pxa.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/io.h>

linux/gpio.h please.
