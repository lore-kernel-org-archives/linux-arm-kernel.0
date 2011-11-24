From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Nov 2011 11:46:37 +0100
Subject: [PATCH v7 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <20111124082312.GA18060@S2100-06.ap.freescale.net>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
 <20111124073605.GI17979@S2100-06.ap.freescale.net>
 <20111124074619.GJ17979@S2100-06.ap.freescale.net>
 <20111124074938.GA8439@pengutronix.de>
 <20111124082312.GA18060@S2100-06.ap.freescale.net>
Message-ID: <20111124104637.GC2563@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.
> > 
> > Please explain.
> > 
> Sorry.  I meant 'select I2C_MXS'.

>From kconfig-language.txt:

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

So, NACK from me.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111124/ea4d9bd3/attachment.sig>
