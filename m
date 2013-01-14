From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jan 2013 11:29:13 -0500 (EST)
Subject: [PATCH] ARM: imx: disable cpu in .cpu_kill hook
In-Reply-To: <50F40E58.4030808@gmail.com>
References: <1358168977-9631-1-git-send-email-shawn.guo@linaro.org>
 <50F40E58.4030808@gmail.com>
Message-ID: <alpine.LFD.2.02.1301141127370.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Rob Herring wrote:

> Setting or clearing the SMP bit is showing up in multiple places
> (big.LITTLE series, Tegra cpuidle). I did inline versions of
> set_auxcr/get_auxcr for highbank cpuidle. We should be make those common.

Could you do that like now and send it to RMK for his stable branch?  
This way I could rebase the b.L series on top.


Nicolas
