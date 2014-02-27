From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 27 Feb 2014 09:46:54 -0600
Subject: [PATCH 1/3] ARM: config: Add qcom_defconfig
In-Reply-To: <1393467394-10907-2-git-send-email-sboyd@codeaurora.org>
References: <1393467394-10907-1-git-send-email-sboyd@codeaurora.org>
 <1393467394-10907-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140227154654.GB7308@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 06:16:32PM -0800, Stephen Boyd wrote:
> Add a defconfig for mach-qcom platforms. Although these platforms
> are part of the multi-platform kernel, it's useful to have a
> stripped down version of the defconfig that just selects the
> Qualcomm based platforms and drivers.

How minimal are we aiming here?  It might be nice to at least get
DEVTMPFS/DEVTMPFS_MOUNT=y in here, as I think udev barfs without it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
