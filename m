From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 07 Aug 2015 10:32:41 +0100
Subject: [PATCH v1 1/7] ARM: dts: ifc6410: Add pwrseq support for WLAN
In-Reply-To: <55B959C4.2090600@codeaurora.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088022-17350-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55B959C4.2090600@codeaurora.org>
Message-ID: <55C47B39.3030607@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/07/15 23:55, Stephen Boyd wrote:
> On 07/28/2015 05:53 AM, Srinivas Kandagatla wrote:
>> +
>> +        sdcc4_pwrseq:pwrseq {
>
> Missing space here between label and node name.
>
I will fix this in next version.
>> +            compatible = "mmc-pwrseq-simple";
>> +            reset-gpios = <&pm8921_gpio 43 GPIO_ACTIVE_LOW>;
>> +        };
>> +
>
> Also this node is not part of the SoC so it should be in the root,
> possibly under some sort of power-sequences node so that all the
> sequences are grouped in one place.
Good spot and suggestion. I will do that in next version.

--srini
>
