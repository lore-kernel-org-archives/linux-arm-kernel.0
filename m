From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Tue, 28 Oct 2014 08:07:49 -0500
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <544ED462.20601@suse.de>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <544C2D67.8000405@suse.de> <544CEC5B.4020104@suse.de>
 <A1BC53C1-A78E-4B0C-879B-F6A462E58C72@suse.de> <544E56DB.7020305@amd.com>
 <544ED462.20601@suse.de>
Message-ID: <544F9525.80304@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 6:25 PM, Alexander Graf wrote:
>
>
> On 27.10.14 15:29, Suravee Suthikulanit wrote:
>> On 10/26/2014 9:08 AM, Alexander Graf wrote:
>>>>> This option doesn't exist in upstream kernels, does it? Why not just
>>>>>>> make it dtb-y?
>>>>>
>>>>> CONFIG_ARCH_SEATTLE is being added one hunk above.:)
>>> Oops:).
>>>
>>> I'm not convinced we need a config option just for the sake of
>>> compiling a device tree though.
>>>
>>>
>>> Alex
>>>
>>
>> Eventually, we would add other device driver selections when
>> CONFIG_ARCH_SEATTLE=y. At this point, those drivers are still not ready.
>
> Could you please give me some examples of drivers that would depend on
> CONFIG_ARCH_SEATTLE? I like the current way things work without the need
> for such an option, where everything's implemented purely as drivers you
> can opt in our out of.
>
> You don't have a CONFIG_ARCH_SB7XX on x86 either, right? ;)
>
>
> Alex
>

I am not saying that device drivers need to depend on 
CONFIG_ARCH_SEATTLE. I am thinking along the line of an easy way to 
enable SOC without having to manually select each of the required 
drivers to support the SOC. An example is the "ARCH_VEXPRESS".

Suravee
