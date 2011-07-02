From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 2 Jul 2011 10:37:54 -0600 (MDT)
Subject: [PATCH 2/2 v4] OMAP2+: hwmod: Add API to check IO PAD wakeup
	status
In-Reply-To: <1309603946-25395-3-git-send-email-govindraj.raja@ti.com>
References: <1309603946-25395-1-git-send-email-govindraj.raja@ti.com>
	<1309603946-25395-3-git-send-email-govindraj.raja@ti.com>
Message-ID: <alpine.DEB.2.00.1107021037040.8874@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2 Jul 2011, Govindraj.R wrote:

> +int omap_hmwod_pad_get_wakeup_status(struct omap_hwmod *oh)
	    ^^^^^

should be "hwmod"


- Paul
