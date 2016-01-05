From: rafael.j.wysocki@intel.com (Rafael J. Wysocki)
Date: Tue, 5 Jan 2016 02:04:11 +0100
Subject: next-20160104 build: 3 failures 15 warnings (next-20160104)
In-Reply-To: <20160104153502.GK16023@sirena.org.uk>
References: <E1aG3zo-0000gt-2t@optimist> <20160104153502.GK16023@sirena.org.uk>
Message-ID: <568B168B.9060001@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/4/2016 4:35 PM, Mark Brown wrote:
> On Mon, Jan 04, 2016 at 12:12:20PM +0000, Build bot for Mark Brown wrote:
>
> Today's linux-next fails to build for arm64 due to 44d3d051253 (ARM64:
> dts: mt8173: Add CPU OPP, clock and regulator supply properties)

Thanks for letting me know, I've dropped this one.

> in one of Raphael's trees:
>
>> 	arm64-allmodconfig
>> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error
>> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error
>> 	arm64-defconfig
>> Error: ../arch/arm64/boot/dts/mediatek/mt8173.dtsi:132.24-25 syntax error
> which is failing because at least CLK_INFRA_CA53SEL is used but never
> defined, presumably there is some dependency which wasn't integrated.
> Normally we merge DT changes via the architecture to help avoid these
> issues.

Yes, that would be better.

Thanks,
Rafael
