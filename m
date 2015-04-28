From: lina.iyer@linaro.org (Lina Iyer)
Date: Tue, 28 Apr 2015 13:58:09 -0600
Subject: [PATCH v19 0/3] ARM: qcom: cpuidle support for 8064, 8074, 8084
In-Reply-To: <D3466AA5-C5E9-4A5E-9EA7-CDD3938A2CCA@codeaurora.org>
References: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
 <D3466AA5-C5E9-4A5E-9EA7-CDD3938A2CCA@codeaurora.org>
Message-ID: <20150428195809.GA424@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28 2015 at 13:32 -0600, Kumar Gala wrote:
>
>> On Apr 9, 2015, at 2:20 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>
>> Hi,
>>
>> This patchset adds acks and reviewed-by tags to the SPM driver and updates the
>> defconfig files to enable cpuidle support on the v18 rev of the patchset [1].
>>
>> The dependencies for these changes are
>> - SCM and device tree changes for QCOM SoCs [2], [4].
>> - cpuidle framework changes [3]
>>
>> Changes since v18:
>> + Add commit tags to SPM driver
>> + Update qcom_defconfig to enable cpuidle support
>> + Update multi_v7_defconfig to enable cpuidle support
>>
>> Thanks,
>> Lina
>>
>> [1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333521.html
>> [2]. https://lkml.org/lkml/2015/3/27/599
>> [3]. https://lkml.org/lkml/2015/3/25/117
>> [4]. https://lkml.org/lkml/2015/1/19/483
>>
>> Lina Iyer (3):
>>  ARM: qcom: Add Subsystem Power Manager (SPM) driver
>>  ARM: config: Update qcom_defconfig to enable cpuidle
>>  ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs
>>
>> arch/arm/configs/multi_v7_defconfig |   2 +
>> arch/arm/configs/qcom_defconfig     |   2 +
>> drivers/soc/qcom/Kconfig            |   7 +
>> drivers/soc/qcom/Makefile           |   1 +
>> drivers/soc/qcom/spm.c              | 385 ++++++++++++++++++++++++++++++++++++
>> 5 files changed, 397 insertions(+)
>> create mode 100644 drivers/soc/qcom/spm.c
>
>Applied.
Thank you so much.

>
>I?ve updated the Kconfig to only be built on ARM32 for now.
>
Sounds good.

Thanks,
Lina
