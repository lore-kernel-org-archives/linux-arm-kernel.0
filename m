From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Dec 2013 12:55:02 +0000
Subject: [PATCH v5 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <7c948660cda4684d28fa97f82295ab84f6ef658e.1386333697.git.stefan@agner.ch>
References: <cover.1386333697.git.stefan@agner.ch>
 <7c948660cda4684d28fa97f82295ab84f6ef658e.1386333697.git.stefan@agner.ch>
Message-ID: <20131206125502.GF29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 01:51:46PM +0100, Stefan Agner wrote:
> Depending on the regulator version, the voltage table might be
> different. Use version specific regulator tables in order to select
> correct voltage table. For the following regulator versions different
> voltage tables are now used:

I think this is the same as the last patch I reviewed but I don't see my
ack on it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/de606f3e/attachment.sig>
