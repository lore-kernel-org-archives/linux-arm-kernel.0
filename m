From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 05 Aug 2014 10:08:43 -0400
Subject: Regarding CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE in
 arch/arm64/configs/defconfig
In-Reply-To: <53E0DB92.2030609@freescale.com>
References: <53E0DB92.2030609@freescale.com>
Message-ID: <53E0E56B.9080601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 09:26 AM, Arnab Basu wrote:
> Hi
> 
> While trying to boot Linux with an initrd I found that CONFIG_BLK_DEV_RAM and
> CONFIG_BLK_DEV_RAM_SIZE are not part of the arm64 defconfig. Is this because
> no one has got around to adding them or is this something that has been
> omitted on purpose?

I've been running initrds fine without this option. What requires it?

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
