From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Jul 2014 20:27:25 +0100
Subject: [patch] ASoC: pxa: pxa-ssp: small leak in probe()
In-Reply-To: <20140731125751.GA31539@mwanda>
References: <20140731125751.GA31539@mwanda>
Message-ID: <20140731192725.GN17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 03:57:51PM +0300, Dan Carpenter wrote:
> There is a small memory leak if probe() fails.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/afd2d0dc/attachment-0001.sig>
