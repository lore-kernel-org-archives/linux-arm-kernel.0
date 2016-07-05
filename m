From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 16:30:40 +0200
Subject: [PATCH v3 10/14] regulator: pwm: Switch to the atomic PWM API
In-Reply-To: <1465895602-31008-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-11-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160705143040.GX6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 11:13:18AM +0200, Boris Brezillon wrote:

> Use the atomic API wherever appropriate and get rid of pwm_apply_args()
> call (the reference period and polarity are now explicitly set when
> calling pwm_apply_state()).

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/47249be8/attachment-0001.sig>
