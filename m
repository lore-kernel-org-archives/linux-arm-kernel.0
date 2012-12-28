From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 28 Dec 2012 16:54:46 -0700
Subject: [PATCH 1/2] ARM: DT: tegra: Add Tegra30 Beaver board support
In-Reply-To: <50DDC743.2080606@gmail.com>
References: <1356032489-27619-1-git-send-email-pengw@nvidia.com>
 <50DDC743.2080606@gmail.com>
Message-ID: <50DE3146.6090001@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2012 09:22 AM, Rob Herring wrote:
> On 12/20/2012 01:41 PM, Bryan Wu wrote:
>> This patch adds support for Tegra30 Beaver board in upstream kernel.

>> diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts

>> +/ {
>> +	model = "NVIDIA Tegra30 Beaver evaluation board";
>> +	compatible = "nvidia,beaver", "nvidia,tegra30";
> 
> nvidia,beaver needs to be documented.

Hmmm. I guess we've managed not to document /any/ of the Tegra
board-level compatible values. Bryan, could you make a separate patch to
add all the existing board compatible values to
Documentation/devicetree/bindings/arm/tegra.txt. The Beaver addition to
that file can still be part of the Beaver-specific patch though.
