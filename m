From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Mar 2011 10:21:47 +0000
Subject: [PATCHv3 2/3] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <1300305787-7970-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1300305787-7970-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300305787-7970-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20110317102147.GG29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 03:03:06PM -0500, Dinh.Nguyen at freescale.com wrote:
> +#include <linux/platform_device.h>
> +#include <asm/io.h>

linux/io.h please.
