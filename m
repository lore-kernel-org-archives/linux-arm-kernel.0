From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Dec 2013 12:14:24 +0000
Subject: [PATCH v4 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
References: <cover.1386108712.git.stefan@agner.ch>
 <127fe07e18665f93aa8d7c03e03164f1a049ddb6.1386108712.git.stefan@agner.ch>
Message-ID: <20131204121424.GN29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 11:18:47PM +0100, Stefan Agner wrote:
> Depending on the regulator version, the voltage table might be
> different. Use version specific regulator tables in order to select
> correct voltage table. For the following regulator versions different
> voltage tables are now used:

Acked-by: Mark Brown <broonie@linaro.org>

I won't apply since I think that patch 3 needs to go along with this,
unless people decide the regulator tree is the easiest way to merge.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/4e21d4ac/attachment-0001.sig>
