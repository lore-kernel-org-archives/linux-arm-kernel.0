From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 May 2015 10:53:06 +0100
Subject: [PATCH 1/2] ASoC: atmel: simplify Kconfig
In-Reply-To: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150526095306.GJ21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 12:04:18AM +0200, Alexandre Belloni wrote:
> Enclose the options in if SND_ATMEL_SOC ... endif to remove the dependency.
> Also remove the useless description for SND_ATMEL_SOC_SSC.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/81ef373e/attachment.sig>
