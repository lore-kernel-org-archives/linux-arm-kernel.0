From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Dec 2016 20:07:29 +0000
Subject: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
In-Reply-To: <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
 <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
Message-ID: <20161209200729.GO14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 11:30:07AM +0100, Gregory CLEMENT wrote:
> Also enable it on the Armada 7040 DB board
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Hi,

Can this also be added to the cp110 on the 7k/8k SoCs as well, or does
it rely on other unmerged support?

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
