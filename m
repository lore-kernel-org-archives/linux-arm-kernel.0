From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 6 May 2011 14:24:40 -0600 (MDT)
Subject: [PATCH v4 1/4] OMAP2+: PM: omap device: API's for handling
	mstandby mode
In-Reply-To: <1301322422-29886-2-git-send-email-manjugk@ti.com>
References: <1301322422-29886-1-git-send-email-manjugk@ti.com>
	<1301322422-29886-2-git-send-email-manjugk@ti.com>
Message-ID: <alpine.DEB.2.00.1105061423570.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Mar 2011, G, Manjunath Kondaiah wrote:

> Certain errata in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.

Thanks, I've queued this one (provisionally) for 2.6.40, assuming we have 
the diffstat budget for it.


- Paul
