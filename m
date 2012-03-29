From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 22:50:13 +0100
Subject: [PATCH v5 02/16] pwm: Allow chips to support multiple PWMs
In-Reply-To: <1332945238-14897-3-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-3-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120329215013.GH4153@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:33:44PM +0200, Thierry Reding wrote:
> Many PWM controllers provide access to more than a single PWM output and
> may even share some resource among them. Allowing a PWM chip to provide
> multiple PWM devices enables better sharing of those resources. As a
> side-effect this change allows easy integration with the device tree
> where a given PWM can be looked up based on the PWM chip's phandle and a
> corresponding index.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/03d467ed/attachment.sig>
