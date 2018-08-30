From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 30 Aug 2018 09:09:52 +0800
Subject: [PATCH 1/6] usb: xhci-mtk: resume USB3 roothub first
In-Reply-To: <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
 <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
Message-ID: <1535591392.32173.30.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wed, 2018-08-29 at 12:13 +0300, Sergei Shtylyov wrote:
> On 8/29/2018 5:55 AM, Chunfeng Yun wrote:
> 
> > Give USB3 devices a better chance to enumerate at USB3 speeds if
> > they are connected to a suspended host.
> > Porting from "671ffdf xhci: resume USB 3 roothub first"
> 
>     From commit 671ffdff5b13 ("xhci: resume USB 3 roothub first").

Ok, Thanks

> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> [...]
> 
> MBR, Sergei
> 
