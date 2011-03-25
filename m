From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 25 Mar 2011 12:46:37 +0100
Subject: mx28 sdio problems (was: Re: [PATCH v4] ARM: mxs/mx28evk: add mmc
	device)
In-Reply-To: <1298364624-19907-1-git-send-email-shawn.guo@freescale.com>
References: <1298284979-14853-7-git-send-email-shawn.guo@freescale.com>
	<1298364624-19907-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <4D8C809D.9010202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2011 09:50 AM, Shawn Guo wrote:
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

I ported these patches to current mainline (the to be released
2.6.39-rc1). mmc works with sd and sdhc cards without problems on my
mx28evk.

However sdio doesn't work. When I plug a sdio wlan card the kernel gives
me the following error messages in a loop:

[ 1002.760000] mmc1: new SDIO card at address 0001
[ 1003.760000] mmc1: card 0001 removed
[ 1003.810000] mmc1: new SDIO card at address 0001
[ 1004.810000] mmc1: card 0001 removed

Any hints how to debug?

cheers, Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110325/5ebbd956/attachment.sig>
