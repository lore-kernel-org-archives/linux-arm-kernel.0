From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jun 2016 14:58:53 +0100
Subject: [PATCH v4 00/14] fix some type infos and bugs for arm64/of numa
In-Reply-To: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20160607135852.GA20477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 04:08:04PM +0800, Zhen Lei wrote:
> v3 -> v4:
> 1. Packed three patches of Kefeng Wang, patch6-8.
> 2. Add 6 new patches(9-15) to enhance the numa on arm64.
> 
> v2 -> v3:
> 1. Adjust patch2 and patch5 according to Matthias Brugger's advice, to make the
>    patches looks more well. The final code have no change. 
> 
> v1 -> v2:
> 1. Base on https://lkml.org/lkml/2016/5/24/679

If you want bug fixes to land in 4.7, you'll need to base them on a
mainline kernel.

Will
