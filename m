From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Jun 2013 10:54:54 +0100
Subject: [PATCH 2/2] regulators: ab3100: bootstrap board power
In-Reply-To: <1371154828-28117-1-git-send-email-linus.walleij@stericsson.com>
References: <1371154828-28117-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130614095454.GF1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 10:20:28PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This moves the code from the platform that is bootstrapping
> the power on the U300 platform out from the machine directory
> and the special-purpose board node and module and into the
> regulator node and driver itself.

Hrm.  Wouldn't this fit better into the new reset framework?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/cdf730b6/attachment.sig>
