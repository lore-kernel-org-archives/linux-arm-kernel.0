From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 13 Dec 2011 11:18:46 +0100
Subject: [PATCH 01/19] mxc_udc: add workaround for ENGcm09152 for i.MX25
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <20111213101846.GC2619@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 07:31:33AM +0100, Eric B?nard wrote:
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX25 when the hardware workaround is also implemented on
> the board.
> It covers the workaround described on page 42 of the following Errata :
> http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf

Nit: The title of the ENG would help reviewing, like it is preferred to
cite patch titles when mentioning the commit-id.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111213/406be699/attachment.sig>
