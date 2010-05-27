From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 20:43:05 +0100
Subject: [PATCH v3] i.MX27: add suspend to RAM support
In-Reply-To: <1274969635-2212-1-git-send-email-eric@eukrea.com>
References: <1274942000-3580-1-git-send-email-eric@eukrea.com>
	<1274969635-2212-1-git-send-email-eric@eukrea.com>
Message-ID: <20100527194305.GB25921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 04:13:55PM +0200, Eric B?nard wrote:
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +#include <asm/io.h>

linux/io.h

(checkpatch.pl will tell you this, although the general rule that "if
there's a linux/foo.h and an asm/foo.h, linux/foo.h should be used"
doesn't always apply - there are some exceptions.)
