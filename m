From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 07 Apr 2017 23:15:01 +0200
Subject: [PATCH] arm64: dts: rockchip: fix the memory size of PX5
 Evaluation board
In-Reply-To: <1491553169-21106-1-git-send-email-andy.yan@rock-chips.com>
References: <1491553169-21106-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <2801207.lkUh043LKq@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 7. April 2017, 16:19:29 CEST schrieb Andy Yan:
> Commit 122682b2abb6 ("arm64: dts: rockchip: Add PX5 Evaluation board")
> sets the memory size to 2 GB, but this board only has 1 GB DRAM, so change
> it to the correct value here.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

I've added a
Fixes: 122682b2abb6 ("arm64: dts: rockchip: Add PX5 Evaluation board")

and applied it for 4.12


Thanks
Heiko
