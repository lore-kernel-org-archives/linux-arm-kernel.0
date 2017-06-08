From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Thu, 8 Jun 2017 09:23:10 +0800
Subject: [PATCH] Revert "ARM: 8433/1: add a VMSPLIT_3G_OPT config option"
In-Reply-To: <20170607093350.GJ4902@n2100.armlinux.org.uk>
References: <1496825972-26829-1-git-send-email-xieyisheng1@huawei.com>
 <20170607093350.GJ4902@n2100.armlinux.org.uk>
Message-ID: <9fbfa9c0-e46f-0f88-4c8f-de8be9114941@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for comment!
On 2017/6/7 17:33, Russell King - ARM Linux wrote:
> On Wed, Jun 07, 2017 at 04:59:32PM +0800, Yisheng Xie wrote:
>> This reverts commit 63ce446c9b5787a94ed875bab20772e1a2b3092f.
> 
> There's no real reason to revert this, thereby removing it from non-LPAE
> cases where it does work.  You've already shown adding a dependency for
> LPAE on this option (or even vice versa) is enough to stop the problem
> occuring.
> 
> IMHO, It would be better to make VMSPLIT_3G_OPT depend on !ARM_LPAE.

OK, I will send a patch as your suggestion.

Thanks
Yisheng Xie
