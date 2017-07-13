From: broonie@kernel.org (Mark Brown)
Date: Thu, 13 Jul 2017 17:01:42 +0100
Subject: [PATCH 01/18] regmap: mmio: Add function to attach a clock
In-Reply-To: <02f409ad80afed68e02660f161fc26d588a86fa7.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <02f409ad80afed68e02660f161fc26d588a86fa7.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170713160142.2buaie6ebqbxunin@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 04:12:56PM +0200, Maxime Ripard wrote:

> This might be problematic if the clock to enable is stored in another node.
> Let's add a function that allows to attach a clock that has already been
> retrieved to a regmap in order to fix this.

What is the use case for this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/30030b03/attachment.sig>
