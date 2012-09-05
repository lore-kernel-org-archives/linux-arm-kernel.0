From: davem@davemloft.net (David Miller)
Date: Wed, 05 Sep 2012 17:32:08 -0400 (EDT)
Subject: [PATCH 09/10] net/macb: ethtool interface: add register dump
 feature
In-Reply-To: <fcd1c2443a30f23ffcd8de28328c5a382e2a2459.1346775479.git.nicolas.ferre@atmel.com>
References: <cover.1346775479.git.nicolas.ferre@atmel.com>
 <fcd1c2443a30f23ffcd8de28328c5a382e2a2459.1346775479.git.nicolas.ferre@atmel.com>
Message-ID: <20120905.173208.1472160105562166368.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 5 Sep 2012 11:00:54 +0200

> @@ -10,6 +10,9 @@
>  #ifndef _MACB_H
>  #define _MACB_H
>  
> +
> +#define MACB_GREGS_LEN 32

Please don't add such extraneous empty lines.  One empty line between
constructs is more than enough, and anything more is visually awkward.

Thanks.
