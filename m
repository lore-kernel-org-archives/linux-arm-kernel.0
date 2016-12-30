From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 10:29:08 +0800
Subject: [PATCH] ARM: dt: imx31: fix AVIC base address
In-Reply-To: <20161117013051.29381-1-vz@mleia.com>
References: <20161117013051.29381-1-vz@mleia.com>
Message-ID: <20161230022907.GI6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 03:30:51AM +0200, Vladimir Zapolskiy wrote:
> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> 
> On i.MX31 AVIC interrupt controller base address is at 0x68000000.
> 
> The problem was shadowed by the AVIC driver, which takes the correct
> base address from a SoC specific header file.
> 
> Fixes: d2a37b3d91f4 ("ARM i.MX31: Add devicetree support")
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

s/dt/dts in the subject, and applied patch, thanks.

Shawn
