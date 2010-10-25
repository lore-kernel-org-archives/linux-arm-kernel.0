From: cjb@laptop.org (Chris Ball)
Date: Mon, 25 Oct 2010 11:57:50 +0100
Subject: [PATCH V4 1/1]MMC: add support of sdhci-pxa driver
In-Reply-To: <AANLkTi=kS7YV4B0OEHNfm1hjCAsgeUHB7cMR10yBwMRF@mail.gmail.com>
References: <AANLkTi=kS7YV4B0OEHNfm1hjCAsgeUHB7cMR10yBwMRF@mail.gmail.com>
Message-ID: <20101025105750.GA30789@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei,

On Mon, Oct 25, 2010 at 06:00:37AM -0400, zhangfei gao wrote:
> Hi, Chris
> 
> Add default working speed in this version, thanks.

I've taken the previous patch version into mmc-next now:

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=536ac998f6076a0ae423b1046b85d7690e8b7107

So, please send further changes as individual patches against the
version in mmc-next, and I'll apply them after the merge.

Are you going to submit a patch to e.g. arch/arm/mach-mmp that hooks
up a platform_device using this driver?

By the way, we used this driver on an OLPC XO-1.75 (MMP2) today.
I haven't finished testing it yet, though.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
