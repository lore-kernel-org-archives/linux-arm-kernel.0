From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 17 May 2012 13:28:57 +0100
Subject: [PATCH 2/2] ARM: s3c64xx: cpuidle - use timekeeping wrapper
In-Reply-To: <1337004377-17732-3-git-send-email-daniel.lezcano@linaro.org>
References: <1337004377-17732-1-git-send-email-daniel.lezcano@linaro.org>
 <1337004377-17732-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120517122857.GH26337@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 04:06:17PM +0200, Daniel Lezcano wrote:
> The timekeeping is computed from the cpuidle core if we set
> the .en_core_tk_irqen flag. Let's use it and remove the duplicated
> code.

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120517/ede2bb6e/attachment.sig>
