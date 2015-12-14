From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Dec 2015 09:30:31 +0800
Subject: [PATCH 4/5] cpufreq: imx6q: Use id_table to distinguish between
 SoCs
In-Reply-To: <1446019154-16384-5-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
 <1446019154-16384-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20151214013031.GN11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 08:59:13AM +0100, Sascha Hauer wrote:
> The i.MX6 cpufreq driver is instantiated from a static device in
> architecture code and not from the device tree. These devices offer the
> id_table mechanism to distinguish between different types of devices.
> Use this mechanism rather than of_machine_is_compatible() as it scales
> better with increasing number of SoCs to check against.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Sorry for my oversight on that Sascha was asking my ACK on this patch in
the cover letter.  Only noticed that with Lucas' ping.

Shawn
