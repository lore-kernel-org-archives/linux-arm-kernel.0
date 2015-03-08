From: broonie@kernel.org (Mark Brown)
Date: Sun, 8 Mar 2015 22:21:43 +0000
Subject: [PATCH] ASoC: davinci-mcasp: add missing semicolon
In-Reply-To: <10196569.gafhWQrdaI@wuerfel>
References: <10196569.gafhWQrdaI@wuerfel>
Message-ID: <20150308222143.GD28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 08, 2015 at 10:10:14PM +0100, Arnd Bergmann wrote:
> A recent patch introduced a build error because of a trivial typo, this
> gets it back to compile.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6afda7f50754 ("ASoC: davinci-mcasp: Allow complete shutdown of McASP when not in use")

The same fix was sent several days ago, please submit against current
code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150308/e0fa66dd/attachment.sig>
