From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Jan 2016 13:03:28 +0000
Subject: [PATCH] ASoC: AMD: add missing include
In-Reply-To: <4595844.NIUnxKiA0y@wuerfel>
References: <4595844.NIUnxKiA0y@wuerfel>
Message-ID: <20160111130328.GB6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 01:13:01PM +0100, Arnd Bergmann wrote:
> The newly added AMD acp driver is missing an include for linux/io.h
> and fails to build on ARM:

Guenter sent a fix for this first.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160111/e8289f5d/attachment.sig>
