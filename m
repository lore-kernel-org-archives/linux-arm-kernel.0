From: zhang.lyra@gmail.com (Chunyan Zhang)
Date: Fri, 22 Dec 2017 13:30:43 +0800
Subject: [PATCH V7 11/12] arm64: dts: add syscon for whale2 platform
In-Reply-To: <20171221230316.GY7997@codeaurora.org>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
 <20171207125715.16160-12-chunyan.zhang@spreadtrum.com>
 <20171221230316.GY7997@codeaurora.org>
Message-ID: <CAAfSe-tc6s6F-1AYEamZubJ7VfMXm-rp18c8pctE51izeHXsnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 December 2017 at 07:03, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 12/07, Chunyan Zhang wrote:
>> Some clocks on SC9860 are in the same address area with syscon
>> devices, the proper syscon node will be quoted under the
>> definitions of those clocks in DT.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>
> These last two can go via arm-soc?

Thanks Stephen!

Hi Arnd, Olof

Could you please take the patch 11, 12 through arm-soc?

Thanks,
Chunyan

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
