From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 26 Feb 2015 20:09:24 +0000
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <54EF748B.3090404@codeaurora.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
 <54EF748B.3090404@codeaurora.org>
Message-ID: <54EF7D74.7060906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/02/15 19:31, Stephen Boyd wrote:
> On 02/22/15 23:54, Srinivas Kandagatla wrote:
>> +			pm8921_s5: pm8921-s5 {
>> +				compatible	= "qcom,rpm-pm8921-ftsmps";
>> +				reg		= <QCOM_RPM_PM8921_SMPS5>;
>> +			};
>> +
>> +			pm8921_s6: pm8921-s6 {
>> +				compatible	= "qcom,rpm-pm8921-ftsmps";
>> +				reg		= <QCOM_RPM_PM8921_SMPS6>;
>> +			};
>> +
>
> There's no RPM control for S5 and S6. Please remove. Also, has this been
> tested?
>
Ahh. these are SAW regulators, I will remove it from the list.
Obviously, I did not test all the regulators.

--srini
