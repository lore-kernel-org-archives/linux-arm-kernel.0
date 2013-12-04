From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 14:29:54 +0000
Subject: [PATCH v4 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <0983a0fa016faa5674834afad4472413@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
 <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
 <20131204121424.GN29268@sirena.org.uk>
 <0983a0fa016faa5674834afad4472413@agner.ch>
Message-ID: <20131204142954.GW29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:17:59PM +0100, Stefan Agner wrote:
> Am 2013-12-04 13:14, schrieb Mark Brown:

> > Acked-by: Mark Brown <broonie@linaro.org>

> > I won't apply since I think that patch 3 needs to go along with this,
> > unless people decide the regulator tree is the easiest way to merge.

> I merged the dependent DT changes into that patch, so from my side,
> patch 3 don't needs to go along with this...

OK, though now I look I see it also depends on patch 1 itself so at
least those two will need to go together.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/813a4258/attachment-0001.sig>
