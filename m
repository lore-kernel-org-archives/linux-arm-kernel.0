From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 22 Feb 2017 18:48:09 +0800
Subject: [PATCH v3 7/8] arm64: dts: mt8173: move clock from phy node
 into port nodes
In-Reply-To: <d2abde73-91b0-36c3-8b32-d50a9800bd52@cogentembedded.com>
References: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
 <1487753705-6745-7-git-send-email-chunfeng.yun@mediatek.com>
 <d2abde73-91b0-36c3-8b32-d50a9800bd52@cogentembedded.com>
Message-ID: <1487760489.7255.5.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wed, 2017-02-22 at 12:36 +0300, Sergei Shtylyov wrote:
> On 2/22/2017 11:55 AM, Chunfeng Yun wrote:
> 
> > there is a reference clock for each port, HighSpeed port is 48M,
> > and SuperSpeed port is 26M which usually comes from 26M oscillator
> > directly, but some SoCs is not. it is flexible to move it into port
> 
>     ... but on some SoCs does not?
I mean the reference clock of SuperSpeed port comes from PLL and need be
controlled by driver on some SoCs. When it comes from oscillator
directly, it is optional and is ok whether the driver controll it or not
> 
> > node.
> >
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> [...]
> 
> MBR, Sergei
> 
