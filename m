From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Mar 2015 00:56:19 +0000
Subject: [PATCH 09/13] spi: atmel: use endian agnostic IO
In-Reply-To: <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150319005619.GL2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 03:53:08PM +0000, Ben Dooks wrote:
> Use the endian agnositc IO functions instead of the __raw ones for when
> the driver is in use on big-endian systems.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I'm not CCed on either the cover letter or the rest of the series: are
there any dependencies here or is it safe to apply this by itself?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150319/a4961eae/attachment-0001.sig>
