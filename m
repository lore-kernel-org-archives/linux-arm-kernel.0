From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 1 Jun 2017 19:23:58 -0500
Subject: Need help booting allmodconfig on arm64
In-Reply-To: <54dae699-cc9d-2c3c-fb81-5e250a51c7f4@gmail.com>
References: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
 <20170601225012.GI22219@n2100.armlinux.org.uk>
 <031b1119-6366-c41f-bf65-01561583ef41@codeaurora.org>
 <54dae699-cc9d-2c3c-fb81-5e250a51c7f4@gmail.com>
Message-ID: <e4e2a740-ac0d-fe30-feae-438948954085@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/1/17 6:54 PM, Florian Fainelli wrote:
>> Now I don't have any /dev/sdX entries, so I can't mount my SATA drive.
>> I'm trying to parse the initramfs disks, but I don't know what to look
>> for.  How do the /dev/sdX entries normally appear?

> What happens when you enable CONFIG_DEVTMPFS and CONFIG_DEVTMPFS_MOUNT?

They are already set to =y.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
