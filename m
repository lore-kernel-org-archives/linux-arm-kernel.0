From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 7 Mar 2017 17:12:55 +0200
Subject: [PATCH 2/2] usb: xhci: remove dummy extra_priv_size for size of
 xhci_hcd struct
In-Reply-To: <20170307110238.GA31069@ulmo.ba.sec>
References: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
 <1488857543-9384-2-git-send-email-chunfeng.yun@mediatek.com>
 <20170307110238.GA31069@ulmo.ba.sec>
Message-ID: <58BECDF7.80003@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.03.2017 13:02, Thierry Reding wrote:
> On Tue, Mar 07, 2017 at 11:32:23AM +0800, Chunfeng Yun wrote:
>> because hcd_priv_size is already size of xhci_hcd struct,
>> extra_priv_size is not needed anymore for MTK and tegra drivers.
>>
>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>>   drivers/usb/host/xhci-mtk.c   |    1 -
>>   drivers/usb/host/xhci-tegra.c |    1 -
>>   2 files changed, 2 deletions(-)
>

Nice catch, thanks.
queued.

> For Tegra:
>
> Tested-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
>

adding tags

-Mathias
