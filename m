From: agraf@suse.de (Alexander Graf)
Date: Tue, 28 Oct 2014 00:25:22 +0100
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <544E56DB.7020305@amd.com>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <544C2D67.8000405@suse.de> <544CEC5B.4020104@suse.de>
 <A1BC53C1-A78E-4B0C-879B-F6A462E58C72@suse.de> <544E56DB.7020305@amd.com>
Message-ID: <544ED462.20601@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27.10.14 15:29, Suravee Suthikulanit wrote:
> On 10/26/2014 9:08 AM, Alexander Graf wrote:
>>>> This option doesn't exist in upstream kernels, does it? Why not just
>>>> >>make it dtb-y?
>>> >
>>> >CONFIG_ARCH_SEATTLE is being added one hunk above.:)
>> Oops:).
>>
>> I'm not convinced we need a config option just for the sake of
>> compiling a device tree though.
>>
>>
>> Alex
>>
> 
> Eventually, we would add other device driver selections when
> CONFIG_ARCH_SEATTLE=y. At this point, those drivers are still not ready.

Could you please give me some examples of drivers that would depend on
CONFIG_ARCH_SEATTLE? I like the current way things work without the need
for such an option, where everything's implemented purely as drivers you
can opt in our out of.

You don't have a CONFIG_ARCH_SB7XX on x86 either, right? ;)


Alex
