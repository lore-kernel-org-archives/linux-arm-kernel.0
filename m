From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 7 Feb 2018 09:44:28 +0530
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <CAL_JsqJ1xjQ5ZP-KXeZQ0s=ib8GTfvfYjFqyy+Zcub-akCs7Bw@mail.gmail.com>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
 <CAL_JsqJ1xjQ5ZP-KXeZQ0s=ib8GTfvfYjFqyy+Zcub-akCs7Bw@mail.gmail.com>
Message-ID: <cf69e160-4f03-f13c-aa39-bd12ed3d9d15@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]..

>>> +             };
>>> +
>>> +             gcc: clock-controller at 100000 {
>>> +                     compatible = "qcom,gcc-sdm845";
>>> +                     reg = <0x100000 0x1f0000>;
>>> +                     #clock-cells = <1>;
>>> +                     #reset-cells = <1>;
>>> +             };
>>> +
>>> +             tlmm: pinctrl at 03400000 {
>>
>> Drop leading zeroes please.
> 
> Build dtbs with W=2 and fix the warnings so reviewers don't have to
> waste their time on these issues.

Noted. Thanks Rob.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
