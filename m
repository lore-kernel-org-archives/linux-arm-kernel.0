From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 16:34:23 +0200
Subject: [PATCH v3 13/14] regulator: pwm: Support extra continuous mode
 cases
In-Reply-To: <1465895602-31008-14-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-14-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160705143423.GA6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 11:13:21AM +0200, Boris Brezillon wrote:
> The continuous mode allows one to declare a PWM regulator without having
> to declare the voltage <-> dutycycle association table. It works fine as
> long as your voltage(dutycycle) function is linear, but also has the
> following constraints:

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/28f0bfe8/attachment.sig>
