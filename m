From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sun, 14 Feb 2016 16:54:18 +0800
Subject: [PATCH 0/6] arm64: hip05: update
In-Reply-To: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <56C040BA.4010701@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping, any comments, thanks.

On 2016/1/29 16:39, Kefeng Wang wrote:
> Enable more feature in hip05 d02 board.
> 
> Kefeng Wang (6):
>   arm64: dts: hip05: Add L2 cache topology
>   arm64: dts: hip05: Use Cortex specific device node for pmu
>   arm64: dts: hip05: Append all gicv3 ITS entries
>   arm64: dts: hip05: Append gpio nodes
>   arm64: dts: hip05: Append power button node for D02 board
>   arm64: defconfig: Enable DesignWare APB GPIO controller
> 
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 18 ++++++
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 92 ++++++++++++++++++++++++++++-
>  arch/arm64/configs/defconfig                |  1 +
>  3 files changed, 109 insertions(+), 2 deletions(-)
> 
