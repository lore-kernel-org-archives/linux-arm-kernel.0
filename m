From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 16 Sep 2014 17:24:16 -0400
Subject: [RFC] arm: Handle starting up in secure mode
In-Reply-To: <1410901756-20694-1-git-send-email-cov@codeaurora.org>
References: <1410901756-20694-1-git-send-email-cov@codeaurora.org>
Message-ID: <5418AA80.4090102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 05:09 PM, Christopher Covington wrote:
> ARM Linux currently has the most features available to it in hypervisor
> (HYP) mode, so switch to it when possible. This can also ensure proper
> reset of newer registers such as CNTVOFF.
> 
> The permissions on the Non-Secure Access Control Register (NSACR) are
> used to probe what the security setting currently is when in supervisor
> (SVC) mode.

Sorry, this doesn't work yet. I was misinterpreting my test results. For what
it's worth, my testing and development methodology is to run it after hacked
up versions of the semihosting bootwrapper on the simulator that corresponds
to rtsm_ve-aemv8a.dtb (AEM VE FVP these days?) and examine the instruction traces.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
