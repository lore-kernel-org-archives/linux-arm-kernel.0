From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 16:44:07 +0100
Subject: [PATCH] regulator: add regulator_can_change_voltage stub
In-Reply-To: <4605709.T97aRyQTUM@wuerfel>
References: <4605709.T97aRyQTUM@wuerfel>
Message-ID: <20140604154407.GM2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 04:46:00PM +0200, Arnd Bergmann wrote:
> When CONFIG_REGULATOR is not set, we cannot call
> regulator_can_change_voltage() from a device driver, which results
> in a build error like

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/cdefb64b/attachment.sig>
