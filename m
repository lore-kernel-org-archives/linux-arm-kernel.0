From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 19 Jan 2017 13:23:53 +0100
Subject: [PATCH 4/6] arm64: dts: mt8173: add reference clock for usb
In-Reply-To: <20170119093747.GA17213@kroah.com>
References: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
 <1484719707-12107-4-git-send-email-chunfeng.yun@mediatek.com>
 <20170119093747.GA17213@kroah.com>
Message-ID: <63ac4f16-5701-db0d-45a2-4af9ea5c57fc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/01/17 10:37, Greg Kroah-Hartman wrote:
> On Wed, Jan 18, 2017 at 02:08:25PM +0800, Chunfeng Yun wrote:
>> add 26M reference clock for ssusb and xhci nodes
>>
>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> This patch doesn't apply to my tree :(
>

This patch should go through my tree, but take into account my comment 
on patch 3/6. From my point of view this series is not ready to be merged.

Regards,
Matthias
