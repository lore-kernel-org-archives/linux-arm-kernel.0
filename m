From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 13:58:52 +0100
Subject: [PATCH 0/7] ARM: hisi: enable HiP01 SoC
In-Reply-To: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
References: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <3601066.g7Jvjk5UFL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 02:15:43 Wang Long wrote:
> This series patch enable Hisilicon HiP01 SoC. The HiP01 SoC series
> chip is designed for networking product, it integrates a rich peripheral
> interfaces to support network applications and supports both one 
> core or dual cores and quad cores. The core is Cortex A9. 

Sorry for the delay in my reply. The patches look good to me, but I'm
not sure what you expect to happen to them. You have a number of
people listed as recipients, but it's not clear if you expect any of
us to apply them into a git tree.

Is Xu Wei going to pick these up in a git tree and send a pull request
to arm at kernel.org?

	Arnd
