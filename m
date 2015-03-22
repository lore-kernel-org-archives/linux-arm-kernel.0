From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Mar 2015 16:03:16 +0000
Subject: [PATCH] ARM: S3C64XX: Use fixed IRQ bases to avoid conflicts on
 Cragganmore
In-Reply-To: <1427020841-24189-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1427020841-24189-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Message-ID: <20150322160316.GB6643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 10:40:41AM +0000, Charles Keepax wrote:
> There are two PMICs on Cragganmore, currently one dynamically assign
> its IRQ base and the other uses a fixed base. It is possible for the
> statically assigned PMIC to fail if its IRQ is taken by the dynamically
> assigned one. Fix this by statically assigning both the IRQ bases.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Reviwed-by: Mark Brown <broonie@kernel.org>

This probably wants to go to stable as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/9eb8281e/attachment.sig>
