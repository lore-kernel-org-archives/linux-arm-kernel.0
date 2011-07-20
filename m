From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 20 Jul 2011 08:52:36 +0300
Subject: [PATCH v2] mtd: dataflash: add device tree probe support
In-Reply-To: <20110720055228.GC5766@S2100-06.ap.freescale.net>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
	<1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
	<20110715025407.GF2927@ponder.secretlab.ca>
	<20110715044919.GB1840@S2100-06.ap.freescale.net>
	<1311136844.20738.131.camel@sauron>
	<20110720045547.GA5766@S2100-06.ap.freescale.net>
	<1311139071.20738.147.camel@sauron>
	<20110720052824.GB5766@S2100-06.ap.freescale.net>
	<1311139971.20738.154.camel@sauron>
	<20110720055228.GC5766@S2100-06.ap.freescale.net>
Message-ID: <1311141162.20738.159.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-07-20 at 13:52 +0800, Shawn Guo wrote:
> The argument about this #ifdef thing was the driver could be used by
> some platforms that will never migrate to device tree.  This table
> will be just a waste of bytes for those platforms, if we do not
> protect the table by '#ifdef CONFIG_OF'.

OK, anyway, I picked your v2 already and less bytes wastage is a good
enough argument.

-- 
Best Regards,
Artem Bityutskiy
