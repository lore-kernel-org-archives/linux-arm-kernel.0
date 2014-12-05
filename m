From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Dec 2014 23:25:14 -0800
Subject: [PATCH v2 0/2] ARM: imx: fix irq_data usage
In-Reply-To: <1417536326-18691-1-git-send-email-marc.zyngier@arm.com>
References: <1417536326-18691-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141205072514.GD29274@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 04:05:24PM +0000, Marc Zyngier wrote:
> IMX has a fairly creative usage of irq_data, which turns into a
> disaster in -next (boards don't even boot).
> 
> These two patches are addressing the most pressing issues, and should
> be merged as early as possible (we've merged a similar patch for tegra
> in 3.18-rc7).
> 
> Thanks,
> 
> 	M.
> 
> From v1: added provided tags.

Hi,

Applied to next/fixes-non-critical for 3.19, should hopefully go in pretty
early during the merge window.


-Olof
