From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Nov 2013 14:22:08 +0000
Subject: [PATCH 2/8] ASoC: fsl-ssi: Move sysfs stats to debugfs
In-Reply-To: <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20131121142208.GU2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 10:04:16AM +0100, Markus Pargmann wrote:

> This patch moves the statistics to debugfs and disables interrupts
> completely if the kernel is build without DEBUG_FS enabled.

We can still see the error counts through /proc/interrupts even without
the debugfs file.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/085ab8bd/attachment-0001.sig>
