From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Mon, 9 Apr 2018 08:38:37 +0300
Subject: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
In-Reply-To: <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
Message-ID: <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

this binding is for a specific IP block (for measuring/aggregating input 
pulses) on the Tegra186 SoC, so I don't think it fits into any generic 
binding.

Thanks,
Mikko

On 03/27/2018 05:52 PM, Rob Herring wrote:
> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>> Supply Device tree binding documentation for the NVIDIA
>> Tegra186 SoC's Tachometer Controller
>>
>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>> ---
>>
>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>      Renamed dt property values of clock-names and reset-names to "tachometer"
>>      from "tach"
> 
> Read my prior comments on v1.
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
