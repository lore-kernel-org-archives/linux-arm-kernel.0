From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 6 Dec 2013 11:59:35 +0530
Subject: [PATCH V3 0/4] ARM: tegra: convert dts files of all Tegra
 platforms to use pinctrl defines
In-Reply-To: <52A10D5C.3060002@wwwdotorg.org>
References: <1386240249-30786-1-git-send-email-ldewangan@nvidia.com>
 <52A10D5C.3060002@wwwdotorg.org>
Message-ID: <52A16ECF.4000209@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013 05:03 AM, Stephen Warren wrote:
> On 12/05/2013 03:44 AM, Laxman Dewangan wrote:
>> This patch series convert dts files of all Tegra's platforms to use the pinctron
>> dt-binding macro for better readability.
> I think this series looks fine now; I'll apply soon pending what happens
> with the DMA/reset/ binding rework.
>
> There are quite a few typos/spelling/capitalization mistakes in the
> commit descriptions, but I'll fix them up when applying.

Thanks for review. I like to also update the dt binding document to use 
thes macro.
Will post the chnage for doc update also.
And I want to refer this for t124 dt binding doc of pinctrl also.


Thanks,
Laxman
