From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 13 Dec 2011 11:16:17 +0100
Subject: [PATCH 03/19] cpuimx25sd: fix Kconfig
In-Reply-To: <1323757911-25217-3-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-3-git-send-email-eric@eukrea.com>
Message-ID: <20111213101617.GB2619@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 07:31:35AM +0100, Eric B?nard wrote:
> in 0d6cfa3a75f5cde5b3ca0dde748fd22625b4f34c I fixed the mach-types
> records. We also need to make the name consistent in Kconfig else
> the machine_is_eukrea_cpuimx25sd macro fails, and thus audio codec
> is not properly initalized.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>

Nit: The subject line is a bit sparse.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111213/6a71e43b/attachment.sig>
