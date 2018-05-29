From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 16:45:24 +0100
Subject: [PATCH 1/3] arm64:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
In-Reply-To: <20180529133615.26889-1-nixiaoming@huawei.com>
References: <20180529133615.26889-1-nixiaoming@huawei.com>
Message-ID: <20180529154523.GK17159@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 09:36:15PM +0800, nixiaoming wrote:
> mark_rodata_ro is only called by the function mark_readonly when
> CONFIG_STRICT_KERNEL_RWX=y,
> if CONFIG_STRICT_KERNEL_RWX is not set
> a compile warning may be triggered: unused function

How are you achieving this configuration? In our Kconfig we select this
unconditionally.

Will
