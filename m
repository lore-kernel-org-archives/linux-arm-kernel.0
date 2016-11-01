From: shawnguo2@vip.163.com (Shawn Guo)
Date: Tue, 1 Nov 2016 16:50:09 +0800
Subject: [PATCH v2 0/4] ARM: imx31: clock initialization fixes
In-Reply-To: <1474848223-19728-1-git-send-email-vz@mleia.com>
References: <1474848223-19728-1-git-send-email-vz@mleia.com>
Message-ID: <20161101085009.GA23220@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2016 at 03:03:39AM +0300, Vladimir Zapolskiy wrote:
> Vladimir Zapolskiy (4):
>   ARM: dts: imx31: fix clock control module interrupts description
>   ARM: dts: imx31: move CCM device node to AIPS2 bus devices
>   clk: imx31: fix rewritten input argument of mx31_clocks_init()
>   ARM: clk: imx31: properly init clocks for machines with DT

Applied all, thanks.
