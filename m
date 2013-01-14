From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 16:46:42 +0000
Subject: [PATCH] ARM: imx: disable cpu in .cpu_kill hook
In-Reply-To: <alpine.LFD.2.02.1301141127370.6300@xanadu.home>
References: <1358168977-9631-1-git-send-email-shawn.guo@linaro.org>
 <50F40E58.4030808@gmail.com> <alpine.LFD.2.02.1301141127370.6300@xanadu.home>
Message-ID: <20130114164642.GI23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:29:13AM -0500, Nicolas Pitre wrote:
> On Mon, 14 Jan 2013, Rob Herring wrote:
> 
> > Setting or clearing the SMP bit is showing up in multiple places
> > (big.LITTLE series, Tegra cpuidle). I did inline versions of
> > set_auxcr/get_auxcr for highbank cpuidle. We should be make those common.
> 
> Could you do that like now and send it to RMK for his stable branch?  
> This way I could rebase the b.L series on top.

Just be clear: I don't think this is something for the stable trees.
