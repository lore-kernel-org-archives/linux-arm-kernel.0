From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 29 Aug 2018 12:13:02 +0300
Subject: [PATCH 1/6] usb: xhci-mtk: resume USB3 roothub first
In-Reply-To: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
Message-ID: <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/29/2018 5:55 AM, Chunfeng Yun wrote:

> Give USB3 devices a better chance to enumerate at USB3 speeds if
> they are connected to a suspended host.
> Porting from "671ffdf xhci: resume USB 3 roothub first"

    From commit 671ffdff5b13 ("xhci: resume USB 3 roothub first").
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
