From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Fri, 09 May 2014 16:20:04 +0200
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
In-Reply-To: <536AC45F.6080608@nvidia.com>
References: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
 <536A57FA.2090608@wwwdotorg.org> <536AC45F.6080608@nvidia.com>
Message-ID: <536CE414.5030406@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.05.2014 01:40, schrieb Alex Courbot:
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
> command-line anyway. Therefore they cannot use a multi-mach kernel

What does appending a .dtb have to do with whether or not to use a
multi-mach kernel? We package zImage/uImage and .dtbs separately, so
surely the multi_v7_defconfig should be kept working with Tegra devices.
Appending a .dtb only comes into play for preparing installation images.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
