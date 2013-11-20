From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Nov 2013 19:48:37 -0500
Subject: [PATCH v2 0/4 - Keystone DTS and clock driver updates]
In-Reply-To: <1384908316-4388-1-git-send-email-m-karicheri2@ti.com>
References: <1384908316-4388-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <528C06E5.2050607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Murali,

On Tuesday 19 November 2013 07:45 PM, Murali Karicheri wrote:
> This patch series add a K2HK (K2 Hawking/Kepler) EVM
> dts file and make some updates to the existing dts
> files and Keystone PLL clk driver.
> 
> Murali Karicheri (4):
>   clk: keystone: use clkod register bits for postdiv
>   keystone: dts: add a k2hk-evm specific dts file
>   keystone: dts: fix typo in the ddr3 pllclk node name
>   keystone: dts: add paclk divider clock node
> 
Thanks for the updates. I will add the dts patches in
my arm-soc queue and also pick the clock patch in
clock updates for Mike to pick it up.

Regards,
Santosh
