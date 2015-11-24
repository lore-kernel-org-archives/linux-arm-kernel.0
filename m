From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 17:00:50 -0800
Subject: [PATCH] nvmem: qfprom: Specify LE device endianness
In-Reply-To: <56507611.8020008@linaro.org>
References: <1448062674-17969-1-git-send-email-sboyd@codeaurora.org>
 <56507611.8020008@linaro.org>
Message-ID: <20151124010050.GO19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21, Srinivas Kandagatla wrote:
> Hi Stephen,
> 
> Thanks for the fix.
> 
> I will send it to Greg for next rc.

Thanks. The change in regmap core that causes the problem is only
in -next. I'm not sure if it's going to hit mainline this release
cycle, so if it doesn't you could queue this for the next
version. No rush.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
