From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Sat, 5 Dec 2015 15:47:26 +0800
Subject: [PATCH RESEND net-next 0/3] dts: hisi: fixes can't find eth for
 hip05-D02
In-Reply-To: <1449302088-53037-1-git-send-email-yankejian@huawei.com>
References: <1449302088-53037-1-git-send-email-yankejian@huawei.com>
Message-ID: <5662968E.9050206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry, pls ignore this patchset.

On 2015/12/5 15:54, yankejian wrote:
> this patchset fixes the bug that eth can't initial successful on hip05-D02
> because the dts files doesn't match the source code.
>
> yankejian (3):
>   dts: hisi: enables the ethX for D02 board
>   dts: hisi: fixes no syscon error when init mdio
>   arm64: hip05-d02: Document devicetree bindings for Hisilicon D02 Board
>
>  .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts              | 16 ++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi                 |  4 ++++
>  arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi             |  4 ++--
>  4 files changed, 38 insertions(+), 2 deletions(-)
>
