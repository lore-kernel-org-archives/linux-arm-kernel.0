From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Wed, 21 Jun 2017 11:37:59 +0300
Subject: [PATCH 3/5] clk: qcom: gdsc: Add support to control associated
 clks
In-Reply-To: <cd47a256-ce8d-92be-b5f6-e57c0613f222@codeaurora.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
 <1490076923-20194-4-git-send-email-rnayak@codeaurora.org>
 <95d69901-fad5-9a2d-138e-ed5eb9dbc4e2@linaro.org>
 <cd47a256-ce8d-92be-b5f6-e57c0613f222@codeaurora.org>
Message-ID: <fce92649-04c6-bdc2-ff28-7b682c9cd573@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On 06/21/2017 09:11 AM, Rajendra Nayak wrote:
> Hey Stan,
> 
> On 06/14/2017 05:10 PM, Stanimir Varbanov wrote:
>> Hi Rajendra,
>>
>> Thanks for the patches!
> 
> thanks for the review, do you plan to use this series to get rid of the mmagic
> clock handling for vidc, or something else?

yes, I have used those patches in the linaro integration branch based on
4.11. So far those patches are working as expected.

> Is this a dependency to get your Video driver patches to work?
> These patches have been on the list for a while and I had asked Stephen to leave
> these out for now till we find someone using them.
> 
> I will fixup based on your review and repost in case its useful for something
> else on the way upstream.

yes, please do.

-- 
regards,
Stan
