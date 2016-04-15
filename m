From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Apr 2016 07:54:23 +0100
Subject: [PATCH v5 07/24] regulator: pwm: use pwm_get_args() where
 appropriate
In-Reply-To: <1460661464-11216-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1460661464-11216-1-git-send-email-boris.brezillon@free-electrons.com>
 <1460661464-11216-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160415065423.GA3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 09:17:27PM +0200, Boris Brezillon wrote:
> The PWM framework has clarified the concept of reference PWM config
> (the platform dependent config retrieved from the DT or the PWM
> lookup table) and real PWM state.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/d5a604e7/attachment.sig>
