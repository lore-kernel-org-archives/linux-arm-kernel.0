From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 18 Mar 2015 17:02:59 +0100
Subject: [PATCH] ARM: mvebu: clk: remove cpuclk resources overlapping
 coredivclk registers on Armada XP
In-Reply-To: <1426596814-30758-1-git-send-email-gregory.clement@free-electrons.com>
References: <1426596814-30758-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150318170259.07ad25e5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Tue, 17 Mar 2015 13:53:34 +0100, Gregory CLEMENT wrote:
> From: Nadav Haklai <nadavh@marvell.com>
> 
> The resources of the cpuclk node are overlapping the one from
> coredivclk node. It was not noticed until now because the driver did a
> simple of_iomap and not a request_mem_region. This patch fixes it.
> 
> [gregory.clement at free-electrons.com: add commit log and port to 4.0-rc]
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
