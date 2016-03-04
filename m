From: huangdaode@hisilicon.com (Daode Huang)
Date: Fri, 4 Mar 2016 08:55:04 +0800
Subject: [PATCH net 0/6]net: hns: hns driver updates
In-Reply-To: <1457053798-93513-1-git-send-email-huangdaode@hisilicon.com>
References: <1457053798-93513-1-git-send-email-huangdaode@hisilicon.com>
Message-ID: <56D8DCE8.2020707@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry. please ignore this mail,
i will send out it again.

On 2016/3/4 9:09, Daode Huang wrote:
> Hi David,
> This patch series are hisilicon network driver bug fix.
>
> Best Regards
> Daode.
>
> Daode Huang (5):
>    net: hns: bug fix about the overflow of mss
>    net: hns: fixes the hw interrupt bug in using napi
>    net: hns: fixed portid bug in sending manage pkt
>    net: hns: adds uc match for debug port
>    net: hns: bug fix of getting hilink status
>
> Lisheng (1):
>    net: hns: fixed service-ges setting MAC-addr bug
>
>   drivers/net/ethernet/hisilicon/hns/hnae.h          |  3 ++
>   drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |  1 +
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 29 ++++++++++++----
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 39 +++++++++++-----------
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  4 +++
>   drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 30 +++++++++--------
>   6 files changed, 67 insertions(+), 39 deletions(-)
>
