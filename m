From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:32:20 -0600
Subject: [PATCH v2 1/3] of: Add NVIDIA Tegra flow controller bindings
In-Reply-To: <53ADE012.5080401@wwwdotorg.org>
References: <1403870848-1754-1-git-send-email-thierry.reding@gmail.com>
 <53ADE012.5080401@wwwdotorg.org>
Message-ID: <53FB7324.9080109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 03:20 PM, Stephen Warren wrote:
> On 06/27/2014 06:07 AM, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Add device tree bindings for the flow controller found on NVIDIA Tegra
>> SoCs.
>>
>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
>
>> +NVIDIA Tegra20 Flow Controller
>> +
>> +Required properties:
>> +- compatible: "nvidia,tegra20-flowctrl"
>> +- reg: Should contain one register range (address and length)
>> +
>> +Example:
>> +
>> +	flow-controller at 60007000 {
>> +		compatible = "nvidia,tegra20-flowctrl";
>> +		reg = <0x60007000 0x1000>;
>> +	};
>
> The bindings all have the same structure. Can we collapse them all into
> this one file and just list all the valid compatible values and say pick
> one?

Thierry, did you post an updated version of this patch? If so, I seem to 
have lost it, so a repost would be good. Thanks.
