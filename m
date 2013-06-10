From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 16:44:55 +0100
Subject: [PATCH] ARM: sirf: use CONFIG_SIRF rather than CONFIG_PRIMA2
 where necessary
In-Reply-To: <201306101736.44652.arnd@arndb.de>
References: <201306101736.44652.arnd@arndb.de>
Message-ID: <20130610154455.GG1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 05:36:44PM +0200, Arnd Bergmann wrote:
> I got a build error today that made me realize that it is not
> possible to build a kernel for a SiRF platform without enabling
> CONFIG_PRIMA2, since a lot of common code depends on CONFIG_PRIMA2.
> 
> This fixes all occurences that appear like common SiRF code.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/8d318e01/attachment.sig>
