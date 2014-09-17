From: kiran.padwal@smartplayin.com (kiran.padwal at smartplayin.com)
Date: Wed, 17 Sep 2014 07:18:19 -0400 (EDT)
Subject: [PATCH] ARM: dts: qcom: Add I2C dt node for MSM8974 and DB8074
 board
In-Reply-To: <306266B7-29AB-474E-855E-F0BE55C9BA11@codeaurora.org>
References: <1410867938-6254-1-git-send-email-kiran.padwal@smartplayin.com>
 <306266B7-29AB-474E-855E-F0BE55C9BA11@codeaurora.org>
Message-ID: <1410952699.0923113@apps.rackspace.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On Tuesday, September 16, 2014 2:59pm, "Kumar Gala" <galak@codeaurora.org> said:

> 
> On Sep 16, 2014, at 4:45 AM, Kiran Padwal <kiran.padwal@smartplayin.com> wrote:
> 
>> Add support for i2c controller on the DB8074 board.
>> It also adds necessary DT support for i2c eeprom which is present on
>> DB8074 board.
>>
>> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
>> ---
>> arch/arm/boot/dts/qcom-apq8074-dragonboard.dts |   21 +++++++++++++++++++++
>> arch/arm/boot/dts/qcom-msm8974.dtsi            |   15 +++++++++++++--
>> 2 files changed, 34 insertions(+), 2 deletions(-)
> 
> Can you rebase this on:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git
> tags/qcom-dt-for-3.18

This patches apply on this tree with no warnings/errors.

> 
> - k
> 
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The
> Linux Foundation
> 
> 
