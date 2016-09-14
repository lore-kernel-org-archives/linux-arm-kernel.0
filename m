From: hotran@apm.com (Hoan Tran)
Date: Wed, 14 Sep 2016 14:06:09 -0700
Subject: [PATCH v3 2/3] clk: xgene: Add PMD clock
In-Reply-To: <20160914205541.GB7243@codeaurora.org>
References: <1473704605-28126-1-git-send-email-hotran@apm.com>
 <1473704605-28126-3-git-send-email-hotran@apm.com>
 <20160914205541.GB7243@codeaurora.org>
Message-ID: <CAFHUOYxc0PBx675j6ZtMWw_nFawT7UMXHa9EE+L=sGyfm=8UmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 1:55 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/12, Hoan Tran wrote:
>> Add X-Gene PMD clock support.
>>
>> PMD clock is implemented for a single register field.
>>   Output rate = parent_rate * (denominator - scale) / denominator
>> with
>>   - denominator = bitmask of register field + 1
>>   - scale = values of register field
>>
>> For example, for bitmask is 0x7, denominator will be 8 and scale
>> will be computed and programmed accordingly.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>
> Applied to clk-next

Thanks, Stephen !

Hoan

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
