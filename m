From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 10:48:42 +0100
Subject: [PATCH v6 16/17] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <1334070400-25013-17-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1334070400-25013-17-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120413094842.GM3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 05:06:39PM +0200, Thierry Reding wrote:
> This commit adds very basic support for device tree probing. Currently,
> only a PWM and a list of distinct brightness levels can be specified.
> Enabling or disabling backlight power via GPIOs is not yet supported.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/612fc777/attachment.sig>
