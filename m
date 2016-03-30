From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Mar 2016 14:23:04 -0700
Subject: [PATCH v5 28/46] regulator: pwm: swith to the atomic PWM API
In-Reply-To: <1459368249-13241-29-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-29-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160330212304.GW2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:51PM +0200, Boris Brezillon wrote:
> pwm_config/enable/disable() have been deprecated in favor of
> pwm_apply_state().
> Replace all those calls with the equivalent pwm_get/apply_state().

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160330/ed4cee9b/attachment.sig>
