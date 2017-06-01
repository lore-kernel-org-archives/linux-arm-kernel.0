From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 1 Jun 2017 18:26:34 -0500
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <20170601225012.GI22219@n2100.armlinux.org.uk>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
Message-ID: <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2017 05:50 PM, Russell King - ARM Linux wrote:
>>
>> It boots to my initramfs, but not my SATA rootfs.  I think the problem
>> is that /init is a shell script, and there's no interpreter?
> Have you checked that BINFMT_SCRIPT is not modular?

That helped, thanks.

Now I don't have any /dev/sdX entries, so I can't mount my SATA drive. 
I'm trying to parse the initramfs disks, but I don't know what to look 
for.  How do the /dev/sdX entries normally appear?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
