From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 6 Apr 2016 11:48:30 +0800
Subject: [PATCH v3 00/14] use of_platform_default_populate() to populate
 default bus
In-Reply-To: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1459835982-26473-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <5704870E.8000102@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 2016/4/5 13:59, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Then it is possible for driver code build as a module, and no
> need to export of_default_bus_match_table anymore.
> 
> This patchset is based on Linux 4.6-rc2.

This patchset isn't a big change, and almost all patches has been added ack or review.
Is it possible to be merged in v4.7, and could anyone help me to pick up them?

Thanks
Kefeng


> 
> Changes since v2:
> - Add more acks
> - Update based on v4.6-rc2, of-generic.c in sh and board-artpec6.c in arm
>   are considered
> 
> Changes since v1:
> - Add ack, test and review
> - Remove v1 patch 14/15, the similar patch has posted and applied,
>   see https://patchwork.kernel.org/patch/8096991/
> 
