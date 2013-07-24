From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Jul 2013 11:20:34 +0100
Subject: [PATCH v2 3/4] Documentation: DT: Add DSPI driver
In-Reply-To: <1374643943-3324-4-git-send-email-b44548@freescale.com>
References: <1374643943-3324-1-git-send-email-b44548@freescale.com>
 <1374643943-3324-4-git-send-email-b44548@freescale.com>
Message-ID: <20130724102034.GA9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 01:32:22PM +0800, Chao Fu wrote:

Please make sure this document is word wrapped to less than 80 columns.

> +-dspi,ctar-dbr : Double baud rate
> +Doubles the effective baud rate of the Serial Communications Clock (SCK). This field is used only in

> +-dspi,ctar-pbr : Baud Rate Prescaler
> +	0: Baud Rate Prescaler value is 2.
> +	1: Baud Rate Prescaler value is 3.
> +	2: Baud Rate Prescaler value is 5.
> +	3: Baud Rate Prescaler value is 7.

Why do these properties need to be set in DT?  They appears to be just
setting the clock rate for the bus so I'd expect them to be configured
based on that rather than manually specified.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130724/6eda3df5/attachment.sig>
