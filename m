From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Jan 2015 12:13:20 +0000
Subject: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
In-Reply-To: <1422533049999.91114@toradex.com>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk>
 <1422533049999.91114@toradex.com>
Message-ID: <20150129121320.GI21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 11:58:25AM +0000, BhuvanChandra.DV wrote:

> As far as i understood the major difference between the two modes are when
> the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
> queue and TCF will trigger the interrupt at every frame transfer. Probably
> mode selection shouldn't be a device tree property, but i don't see any
> automatic way to choose between the modes.
> Maybe a config would be more appropriate?

Or if there's either no particular reason to choose one over the other
or one is always better then just pick one in the driver and don't worry
about implementing both.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/48763654/attachment.sig>
