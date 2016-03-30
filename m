From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Mar 2016 14:22:24 -0700
Subject: [PATCH v5 27/46] regulator: pwm: adjust PWM config at probe time
In-Reply-To: <1459368249-13241-28-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-28-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160330212224.GV2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:50PM +0200, Boris Brezillon wrote:
> The PWM attached to a PWM regulator device might have been previously
> configured by the bootloader.
> Make sure the bootloader and linux config are in sync, and adjust the PWM
> config if that's not the case.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/0dba77c2/attachment.sig>
