From: svarbanov@mm-sol.com (Stanimir Varbanov)
Date: Wed, 12 Feb 2014 11:28:21 +0200
Subject: [PATCH] ARM: dts: qcom: Add RNG device tree node
In-Reply-To: <20140208033740.GD10784@codeaurora.org>
References: <1391764987-17138-1-git-send-email-svarbanov@mm-sol.com>
 <20140208033740.GD10784@codeaurora.org>
Message-ID: <52FB3EB5.4020207@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stephen

On 02/08/2014 05:37 AM, Stephen Boyd wrote:
> On 02/07, Stanimir Varbanov wrote:
>> Add the necessary DT node to probe the rng driver on
>> msm8974 platforms.
>>
> 
> Looks good. We should add it to msm8960-cdp and enable the driver
> in the defconfig as well.

Sure, I can prepare a patch. Unfortunately I haven't msm8960 CDP to test it.

> 
>> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 

Thanks!

regards,
Stan
