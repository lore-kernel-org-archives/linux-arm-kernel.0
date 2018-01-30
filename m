From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 30 Jan 2018 14:18:45 +0530
Subject: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <CAE=gft7hEc1GGJeYk0LRq1FAZyZhujfPWAnc=y+-HLzLKbVgtw@mail.gmail.com>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <CAE=gft7hEc1GGJeYk0LRq1FAZyZhujfPWAnc=y+-HLzLKbVgtw@mail.gmail.com>
Message-ID: <201dcf54-768d-6928-5997-94157e6adb98@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/27/2018 02:01 AM, Evan Green wrote:
> Hi Rajendra,
> 
> On Thu, Jan 25, 2018 at 8:32 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts  |  13 ++
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi |  11 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi     | 308 +++++++++++++++++++++++++++++++
>>  4 files changed, 333 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 55ec5ee7f7e8..c57701bed084 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8916-mtp.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-bullhead-rev-101.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += sdm845-mtp.dtb
> 
> Minor nit: This should be a tab before the += to be consistent.

thanks, will fix when I respin.

> 
> (Unfortunately I don't have the expertise quite yet to comment on the
> rest of this).
> 
> -Evan
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
