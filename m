From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Apr 2013 12:20:34 +0100
Subject: [PATCH V2 0/4] arm64: Initial patch-set for APM X-Gene SOC family
In-Reply-To: <1366712759-3431-1-git-send-email-vkale@apm.com>
References: <1366712759-3431-1-git-send-email-vkale@apm.com>
Message-ID: <20130423112034.GE23407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinayak,

On Tue, Apr 23, 2013 at 11:25:55AM +0100, Vinayak Kale wrote:
> These are initial patches for APM X-Gene SOC family.
> This patch-set is based on soc-armv8-model branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git

The patches look ok to me but let's see if there are any other comments
on the dts files.

Since we go with a common defconfig, I'll drop the vexpress_defconfig as
well. There are dependencies on GIC and some other vexpress patches to
go into mainline before I can push my soc-armv8-model changes. I'll
queue your patches for 3.11 (after this merging window).

Thanks.

-- 
Catalin
