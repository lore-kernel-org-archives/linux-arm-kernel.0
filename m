From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 22 Mar 2017 18:13:27 +0000
Subject: [PATCH V2 4/5] dt-bindings: tegra: Update compatible strings for
 Tegra flowctrl
In-Reply-To: <b85e7f4e-ba63-8374-b10d-3f9f04252a69@wwwdotorg.org>
References: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
 <1490202056-13040-5-git-send-email-jonathanh@nvidia.com>
 <b85e7f4e-ba63-8374-b10d-3f9f04252a69@wwwdotorg.org>
Message-ID: <58983614-8f75-b498-e544-5121a16d5d19@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 22/03/17 17:26, Stephen Warren wrote:
> On 03/22/2017 11:00 AM, Jon Hunter wrote:
>> Update the compatible strings for Tegra Flow Control driver to match
>> the device-tree source files for Tegra.
> 
>> +++
>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
> 
>> +  - "nvidia,tegra124-flowctrl": for Tegra124 and Tegra132
> 
> I think that should be:
> 
> +  - "nvidia,tegra124-flowctrl": for Tegra124
> +  - "nvidia,tegra132-flowctrl", "nvidia,tegra124-flowctrl": for \
> Tegra132

This is based upon the current tegra132.dtsi file which just has ...

	flow-controller at 60007000 {
		compatible = "nvidia,tegra124-flowctrl";
		...

So I can fix-it up if that is what we want/should have. I have a feeling
there are a few other cases like this.

Cheers
Jon

-- 
nvpublic
