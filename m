From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Mar 2015 14:14:03 +0000
Subject: [PATCH 02/10] ASoC: samsung/smartq: use dynamic registration
In-Reply-To: <1425299763-4066822-3-git-send-email-arnd@arndb.de>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-3-git-send-email-arnd@arndb.de>
Message-ID: <20150303141403.GR21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 01:35:55PM +0100, Arnd Bergmann wrote:
> As a prerequisite for moving s3c64xx into multiplatform configurations,
> we need to change the smartq audio driver to stop using hardcoded
> gpio numbers from the header file, and instead pass the gpio data
> through platform_data.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150303/b36dbcb7/attachment-0001.sig>
