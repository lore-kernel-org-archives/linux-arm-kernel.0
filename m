From: broonie@kernel.org (Mark Brown)
Date: Sun, 23 Feb 2014 14:12:09 +0900
Subject: [PATCH v3 0/2] regulator: core: Fix ops->enable/disable usage
In-Reply-To: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
References: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140223051209.GK25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 05:36:02PM +0100, Markus Pargmann wrote:
> Hi,
> 
> These two patches replace all ops->enable/disable by
> _regulator_do_disable/enable function calls. These wrappers also handle gpio
> regulators.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140223/89983088/attachment.sig>
