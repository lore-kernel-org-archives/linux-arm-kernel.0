From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 13 Apr 2012 10:47:19 +0100
Subject: [PATCH v6 04/17] pwm: Add table-based lookup for static mappings
In-Reply-To: <1334070400-25013-5-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <1334070400-25013-5-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120413094718.GL3168@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 05:06:27PM +0200, Thierry Reding wrote:
> In order to get rid of the global namespace for PWM devices, this commit
> provides an alternative method, similar to that of the regulator or
> clock frameworks, for registering a static mapping for PWM devices. This
> works by providing a table with a provider/consumer map in the board
> setup code.
> 
> With the new pwm_get() and pwm_put() functions available, usage of
> pwm_request() and pwm_free() becomes deprecated.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120413/b9114ebf/attachment.sig>
