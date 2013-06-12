From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 11:41:28 -0600
Subject: [PATCH V2 3/3] ARM: tegra114: cpuidle: add powered-down state
In-Reply-To: <51AE5EE3.3010607@linaro.org>
References: <1370342880-422-1-git-send-email-josephl@nvidia.com>
 <1370342880-422-4-git-send-email-josephl@nvidia.com>
 <51AE5EE3.3010607@linaro.org>
Message-ID: <51B8B2C8.1090006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 03:40 PM, Daniel Lezcano wrote:
> On 06/04/2013 12:48 PM, Joseph Lo wrote:
>> This supports CPU core power down on each CPU when CPU idle. When CPU go
>> into this state, it saves it's context and needs a proper configuration
>> in flow controller to power gate the CPU when CPU runs into WFI
>> instruction. And the CPU also needs to set the IRQ as CPU power down idle
>> wake up event in flow controller.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> 
> I would like to understand why there is a WARN with the
> CPUIDLE_FLAG_TIMER_STOP flag set before queuing this patch and ensure it
> is not the tree hiding the forest.

Joseph, are you planning to post an updated series or respond to resolve
Daniel's question?
