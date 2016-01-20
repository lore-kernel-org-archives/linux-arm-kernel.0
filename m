From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 20 Jan 2016 13:02:25 +0100
Subject: [PATCH] iommu/arm-smmu: add a shortcut when the @dev_node is NULL
In-Reply-To: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
References: <1452564905-2662-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20160120120225.GD18805@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 10:15:05AM +0800, Huang Shijie wrote:
> This patch adds a shortcut for the code when the @device_node is NULL.
> In my juno-r1 board, the boot time can be faster by 0.004014s.

How have you made sure this number is reliable and not just noise in the
boot process?


	Joerg
