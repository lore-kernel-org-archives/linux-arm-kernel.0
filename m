From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 16 Apr 2012 19:47:39 +0100
Subject: [PATCH v4 1/2] mfd: add irq domain support for max8997 interrupts
In-Reply-To: <1332582590-16382-2-git-send-email-thomas.abraham@linaro.org>
References: <1332582590-16382-1-git-send-email-thomas.abraham@linaro.org>
 <1332582590-16382-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120416184739.GG3219@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2012 at 03:19:49PM +0530, Thomas Abraham wrote:
> Add irq domain support for max8997 interrupts. The reverse mapping method
> used is linear mapping since the sub-drivers of max8997 such as regulator
> and charger drivers can use the max8997 irq_domain to get the linux irq
> number for max8997 interrupts. All uses of irq_base in platform data and
> max8997 driver private data are removed.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120416/05c3cb4d/attachment.sig>
