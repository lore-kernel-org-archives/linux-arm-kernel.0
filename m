From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 11:02:27 +0100
Subject: [PATCH v4 01/31] spi: mpc512x: cleanup clock API use
In-Reply-To: <1375821851-31609-2-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-2-git-send-email-gsi@denx.de>
Message-ID: <20130822100227.GT26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 10:43:41PM +0200, Gerhard Sittig wrote:
> cleanup the MPC512x SoC's SPI master's use of the clock API
> - get, prepare, and enable the MCLK during probe; disable, unprepare and
>   put the MCLK upon remove; hold a reference to the clock over the
>   period of use

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/02ff2956/attachment.sig>
