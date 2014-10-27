From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 13:37:21 -0700
Subject: [PATCHv2 8/9] arm: perf: dynamically allocate cpu hardware data
In-Reply-To: <1414411599-1938-9-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
 <1414411599-1938-9-git-send-email-mark.rutland@arm.com>
Message-ID: <544EAD01.4020700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 05:06 AM, Mark Rutland wrote:
> To support multiple PMUs, each PMU will need its own accounting data.
> As we don't know how (in general) many PMUs we'll have to support at
> compile-time, we must allocate the data at runtime dynamically
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
