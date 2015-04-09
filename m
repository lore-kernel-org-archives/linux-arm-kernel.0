From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 9 Apr 2015 11:10:17 +0200
Subject: [PATCHv7] media: i2c/adp1653: Devicetree support for adp1653
In-Reply-To: <20150409074238.GA22603@amd>
References: <20150402203417.GA6336@amd> <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd>
Message-ID: <20150409091017.GA4526@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> [...]
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> [...]

This should probably be

#include <linux/of.h>
#include <linux/gpio/consumer.h>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/db10f0dd/attachment.sig>
