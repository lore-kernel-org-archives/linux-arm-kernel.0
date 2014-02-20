From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Feb 2014 22:17:45 +0900
Subject: [PATCH v2 2/2] regulator: core: Replace direct ops->disable usage
In-Reply-To: <20140220130108.GD21048@pengutronix.de>
References: <1392894472-11956-1-git-send-email-mpa@pengutronix.de>
 <1392894472-11956-3-git-send-email-mpa@pengutronix.de>
 <20140220125130.GQ2669@sirena.org.uk>
 <20140220130108.GD21048@pengutronix.de>
Message-ID: <20140220131744.GR2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 02:01:08PM +0100, Markus Pargmann wrote:

> I am using this function from _regulator_force_disable(), which calls
> _notifier_call_chain() with one additional flag
> "REGULATOR_EVENT_FORCE_DISABLE". To prevent calling
> _notifier_call_chain() twice for the force_disable case, I moved that
> function call out of _regulator_do_disable().

OK, put that in the changelog please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/c13b83e8/attachment.sig>
