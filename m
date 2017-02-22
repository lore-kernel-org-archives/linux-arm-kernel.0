From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 22 Feb 2017 12:36:21 +0300
Subject: [PATCH v3 7/8] arm64: dts: mt8173: move clock from phy node into
 port nodes
In-Reply-To: <1487753705-6745-7-git-send-email-chunfeng.yun@mediatek.com>
References: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
 <1487753705-6745-7-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <d2abde73-91b0-36c3-8b32-d50a9800bd52@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/22/2017 11:55 AM, Chunfeng Yun wrote:

> there is a reference clock for each port, HighSpeed port is 48M,
> and SuperSpeed port is 26M which usually comes from 26M oscillator
> directly, but some SoCs is not. it is flexible to move it into port

    ... but on some SoCs does not?

> node.
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
