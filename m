From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 Feb 2017 12:34:56 +0300
Subject: [PATCH v3 4/8] phy: phy-mt65xx-usb3: move clock from phy node
 into port nodes
In-Reply-To: <1487753705-6745-4-git-send-email-chunfeng.yun@mediatek.com>
References: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
 <1487753705-6745-4-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <9c4b9e9d-d50c-0941-1712-2715c64b0a0e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 2/22/2017 11:55 AM, Chunfeng Yun wrote:

> the reference clock of HighSpeed port is 48M which comes from PLL;
> the reference clock of SuperSpeed port is 26M which usually comes
> from 26M oscillator directly, but some SoCs are not, add it for

     ... but on some SoCs does not?

> compatibility, and put them into port node for flexibility.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
