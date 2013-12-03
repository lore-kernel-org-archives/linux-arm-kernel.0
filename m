From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 11:59:42 -0700
Subject: [PATCH 04/31] ARM: tegra: update DT files to add reset properties
In-Reply-To: <20131129130031.GQ22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-5-git-send-email-swarren@wwwdotorg.org>
 <20131129130031.GQ22771@ulmo.nvidia.com>
Message-ID: <529E2A1E.1000307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 06:00 AM, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:53:59PM -0700, Stephen Warren wrote:
...
>> @@ -110,6 +118,8 @@ reg = <0x54080000 0x00040000>; interrupts =
>> <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>; clocks = <&tegra_car
>> TEGRA30_CLK_VI>; +			resets = <&tegra_car 164>;
> 
> I think this needs to be 20.

Yes, I've fixed that to be 20 in both tegra20.dtsi and tegra30.dtsi in
this patch.
