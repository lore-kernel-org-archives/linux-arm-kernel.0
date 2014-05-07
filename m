From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 May 2014 17:35:54 -0600
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
In-Reply-To: <536AC45F.6080608@nvidia.com>
References: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
 <536A57FA.2090608@wwwdotorg.org> <536AC45F.6080608@nvidia.com>
Message-ID: <536AC35A.3000103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2014 05:40 PM, Alex Courbot wrote:
> On 05/08/2014 12:57 AM, Stephen Warren wrote:
>> On 05/06/2014 09:18 PM, Alexandre Courbot wrote:
>>> Console rotation is needed for devices like Tegra Note 7 and NVIDIA
>>> SHIELD to get the boot console in the expected orientation.
>>
>> I've squashed this into Tegra's for-3.16/defconfig branch.
>>
>> Can you please also update multi_v7_defconfig, and send that change to
>> arm-soc (arm at kernel.org) to be applied. Thanks.
> 
> I omitted doing this for now because the devices that require this
> option (TN7/SHIELD) need a custom build with appended DTB and/or
> command-line anyway. Therefore they cannot use a multi-mach kernel and
> might as well be built against Tegra's defconfig. Does your remark above
> still apply in spite of this?

Ah right, I guess we don't need it there then.
