From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Jul 2015 11:51:54 +0100
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <20150730095051.06eff8b1@bbrezillon>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150730095051.06eff8b1@bbrezillon>
Message-ID: <20150730105154.GN11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 09:50:51AM +0200, Boris Brezillon wrote:

> Since you have to patch your DTs anyway, how about putting your
> partitions in a subnode and patch the ofpart code to parse this subnode
> if it is present (see the following patch).

This is the best idea, yes - if we're changing the DT for the system
anyway then making a sane binding and using that seems better than
trying to mitigate problems with the old bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/7f52e8c2/attachment.sig>
