From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Aug 2011 17:15:07 +0200
Subject: [PATCH] ARM: msm: defconfigs for Qualcomm dev boards
In-Reply-To: <1314664573-18432-1-git-send-email-davidb@codeaurora.org>
References: <1314664573-18432-1-git-send-email-davidb@codeaurora.org>
Message-ID: <201108301715.07450.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 August 2011, David Brown wrote:
> Add default configs for the development boards for several Qualcomm
> MSM-family chips.
> 
> Signed-off-by: David Brown <davidb@codeaurora.org>
> ---
> These are my current defconfigs for these targets.  I'd like to get
> these into next so that the targets can get build tested.  I'm not
> sure if we want to push them to mainline, since devicetree would
> theoretically eliminate the need for all of them.

I think it's reasonable to have them in mainline while the device
tree support on MSM is still incomplete, but I can also just
stick them in to a branch that I don't submit to mainline
if you prefer to have them only in linux-next.

Russell, if you want to keep the defconfig files under your
ownership, that's also fine with me. In that case:
Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
