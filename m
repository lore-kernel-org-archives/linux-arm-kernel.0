From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Mar 2016 10:23:03 +0000
Subject: [PATCH] arm64: defconfig: fix override warning of MMC_BLOCK_MINORS
In-Reply-To: <56F11B4C.6030608@arm.com>
References: <1458533284-23010-1-git-send-email-wangkefeng.wang@huawei.com>
 <56F11B4C.6030608@arm.com>
Message-ID: <20160322102302.GE31126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 10:15:40AM +0000, Andre Przywara wrote:
> (Adding Will, who usually takes care of this)

Gah, I don't usually take care of this! As I said before, I just pick
up the bits and pieces that are left at -rc1. The more than can be merged
through arm-soc, the better.

> On 21/03/16 04:08, Kefeng Wang wrote:
> > The commit 2f85bb09d95e ("arm64: defconfig: Increase MMC_BLOCK_MINORS to
> > 16") and commit 22b0898e831b ("arm64: add defconfig options for Allwinner
> > SoCs") both add MMC_BLOCK_MINORS to defconfig, which leads to override
> > warning, fix it.
> 
> Looks good to me.
> 
> Will, do you just want to fix it up with your defconfig update planned
> for after -rc1 anyway?

I'll try to make sure that it doesn't fall on the floor.

Will
