From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Jul 2015 19:43:45 +0100
Subject: next-20150722 build: 2 failures 75 warnings (next-20150722)
In-Reply-To: <E1ZHv2t-0004JI-0H@optimist>
References: <E1ZHv2t-0004JI-0H@optimist>
Message-ID: <20150722184345.GB11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 22, 2015 at 03:30:56PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig due to:

> ERROR: "of_default_bus_match_table" [drivers/memory/pl172.ko] undefined!

17c50b700c3b4 (memory: add ARM PL172 MultiPort Memory Controller
driver).  The symbol of_default_bus_match_table isn't exported by the OF
core code so can't be referenced from modules.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150722/82109b2c/attachment.sig>
