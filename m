From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Feb 2014 11:56:14 -0800
Subject: [PATCH 1/3] ARM: config: Add qcom_defconfig
In-Reply-To: <20140227154654.GB7308@joshc.qualcomm.com>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
 <1393467394-10907-2-git-send-email-sboyd@codeaurora.org>
 <20140227154654.GB7308@joshc.qualcomm.com>
Message-ID: <530F985E.5030503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/14 07:46, Josh Cartwright wrote:
> On Wed, Feb 26, 2014 at 06:16:32PM -0800, Stephen Boyd wrote:
>> Add a defconfig for mach-qcom platforms. Although these platforms
>> are part of the multi-platform kernel, it's useful to have a
>> stripped down version of the defconfig that just selects the
>> Qualcomm based platforms and drivers.
> How minimal are we aiming here?  It might be nice to at least get
> DEVTMPFS/DEVTMPFS_MOUNT=y in here, as I think udev barfs without it.
>

Sure that's fine as others are doing the same. I'll send a v1.1.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
