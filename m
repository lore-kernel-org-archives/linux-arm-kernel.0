From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 25 Aug 2014 11:35:42 -0600
Subject: [PATCH v2 1/4] of: Add NVIDIA Tegra Legacy Interrupt Controller
 binding
In-Reply-To: <53B1C948.6050603@wwwdotorg.org>
References: <1403917351-13215-1-git-send-email-thierry.reding@gmail.com>
 <53B1C948.6050603@wwwdotorg.org>
Message-ID: <53FB73EE.7000508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2014 02:32 PM, Stephen Warren wrote:
> On 06/27/2014 07:02 PM, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> The Legacy Interrupt Controller found on NVIDIA Tegra SoCs is used by
>> the AVP coprocessor and can also serve as a backup for the ARM Cortex
>> CPU's local interrupt controller (GIC).
>>
>> The LIC is subdivided into multiple identical units, each handling 32
>> possible interrupt sources.
>
> The series looks OK to me, although I guess there will be a V3 to
> address Mark's comments?

Thierry, do you still want this series applied? I'm not sure if it's 
required by or conflicts with any of your later patches to move code out 
of arch/arm/mach-tegra/?

If this series should still be applied, I guess I can fix up Mark's 
remaining comment (the bracketing of the multiple reg entries in the DT) 
when applying it, at least if you don't want to repost it yourself.
