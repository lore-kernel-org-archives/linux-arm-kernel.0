From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Apr 2012 10:55:12 +0100
Subject: [PATCH] hwrng: Kconfig: modify default state for atmel-rng driver
In-Reply-To: <1335779353-9515-1-git-send-email-nicolas.ferre@atmel.com>
References: <20120427173504.GK18260@opensource.wolfsonmicro.com>
 <1335779353-9515-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120430095511.GC3170@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 11:49:13AM +0200, Nicolas Ferre wrote:
> In order to prevent building the Atmel hw_random driver for each and every
> configuration, add a "default" Kconfig state in relation with
> CONFIG_ARCH_AT91.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/5f19a4a3/attachment.sig>
