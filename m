From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 3 Apr 2012 21:26:53 +0200
Subject: [PATCH 3/3] ARM: mx28evk: Add SPI NOR flash support
In-Reply-To: <1333480807-10480-3-git-send-email-festevam@gmail.com>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
 <1333480807-10480-3-git-send-email-festevam@gmail.com>
Message-ID: <20120403192653.GA2201@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Apr 03, 2012 at 04:20:07PM -0300, Fabio Estevam wrote:
> Add SPI NOR flash support.
> 
> By default, the mx28evk board does not come with a SPI NOR flash populated.
> 
> Soldered a sst25vf016b and tested it using mtd-utils.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I will submit the spi-mxs driver in a day or so.

\o/ Looking forward to that one!

However, I think this patch should include registering the spi-device as well?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120403/5c2522cd/attachment.sig>
