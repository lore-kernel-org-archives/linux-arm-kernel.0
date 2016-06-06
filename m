From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Jun 2016 19:04:11 +0100
Subject: [PATCH 3/5] regulator: rn5t618: add RN5T567 PMIC support
In-Reply-To: <c6edd422420533d16c076ad5e721e549@agner.ch>
References: <20160605001749.4062-1-stefan@agner.ch>
 <20160605001749.4062-5-stefan@agner.ch>
 <20160606173539.GC7510@sirena.org.uk>
 <c6edd422420533d16c076ad5e721e549@agner.ch>
Message-ID: <20160606180411.GG7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 10:47:40AM -0700, Stefan Agner wrote:
> On 2016-06-06 10:35, Mark Brown wrote:

> > Acked-by: Mark Brown <broonie@kernel.org>

> Thanks Mark.

> Do you have an idea how the patchset should be handled with the
> dependent dt change in patch 1?

Lee will need to apply at least the first patch, I'd expect he'll also
apply this and send me a pull request (or perhaps just send me a pull
request for the MFD change).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/5bd19d37/attachment.sig>
