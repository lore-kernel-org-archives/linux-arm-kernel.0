From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 12:30:25 +0800
Subject: [PATCH v2 08/11] ARM: s3c64xx: dt: Enable SoC-level power
 management
In-Reply-To: <1393862536-9842-9-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-9-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140305043025.GJ13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 05:02:13PM +0100, Tomasz Figa wrote:
> This patch adds call to s3c64xx_pm_init() from init_machine() callback
> of mach-s3c64xx-dt to enable SoC-level power management features, such
> as power domain management and sleep support.

Reviewed-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/7b530bb5/attachment.sig>
