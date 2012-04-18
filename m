From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Apr 2012 17:45:01 +0100
Subject: [PATCH v5 1/2] mfd: add irq domain support for max8997 interrupts
In-Reply-To: <1334741463-25058-2-git-send-email-thomas.abraham@linaro.org>
References: <1334741463-25058-1-git-send-email-thomas.abraham@linaro.org>
 <1334741463-25058-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120418164501.GC3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 03:01:02PM +0530, Thomas Abraham wrote:

>  struct max8997_platform_data {
>  	/* IRQ */
> -	int irq_base;
>  	int ono;
>  	int wakeup;

This will *still* break the build.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/ba991db2/attachment.sig>
