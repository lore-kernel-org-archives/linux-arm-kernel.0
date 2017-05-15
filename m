From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 00:28:26 +0100
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <1494890913-8360-2-git-send-email-mw@semihalf.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
Message-ID: <20170515232825.GX22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 01:28:32AM +0200, Marcin Wojtas wrote:
> This patch adds following improvements to Armada 8040
> MachiatoBin:
>  * Add 'chosen' node with stdout-path assignment
>  * Enable 1G sgmii port
>  * Enable SDHCI controllers on AP and CP HW blocks
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Please check my repository at:

	git://git.armlinux.org.uk/~rmk/linux-arm.git mcbin

I'm currently in the big post-merge window rebase, but that branch has
almost complete support for the board, including work in progress for
upgrading phylib for 10G support.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
