From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 02 Dec 2015 07:59:01 +0530
Subject: [PATCH v2] arm64: dts: qcom: Add apq8096 dragonboard dts skeletons
In-Reply-To: <565E1146.7050207@codeaurora.org>
References: <1448986275-16807-1-git-send-email-rnayak@codeaurora.org>
 <565E1146.7050207@codeaurora.org>
Message-ID: <565E576D.9010501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/02/2015 02:59 AM, Bryan Huntsman wrote:
> On 12/01/2015 08:11 AM, Rajendra Nayak wrote:
>> Add new dtsi and dts files for the apq8096 dragonboards with just
>> a serial device used as debug console
>>
>> While at it, also rearrange the Makefile so we have one dtb per line
>> so as to be consistent with whats done on other platforms.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile                 |  4 ++-
>>  arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts  | 21 ++++++++++++++++
>>  arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi | 30 +++++++++++++++++++++++
>>  3 files changed, 54 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/boot/dts/qcom/apq8096-dragonboard.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/apq8096-dragonboard.dtsi
> 
> One problem.  The board you have is not called a dragonboard.  Let's
> check with the marketing folks on what they're calling it now.  We need
> to explicitly avoid using dragonboard here as that name applies to a
> different class of products.  Thanks.

Thanks Bryan, I'll update with the new board name.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
