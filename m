From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 Oct 2015 10:01:43 +0900
Subject: [PATCH] ARM: shmobile: porter: enable internal PCI and USB PHY
In-Reply-To: <4574604.BmF3DtBjpm@wasted.cogentembedded.com>
References: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
 <4574604.BmF3DtBjpm@wasted.cogentembedded.com>
Message-ID: <20151013010142.GA4836@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 01:12:18AM +0300, Sergei Shtylyov wrote:
> Enable  internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached
> to them and also enable  USB PHY device  for the Porter board.  We have to
> enable  everything in one patch since EHCI/OHCI devices are already linked
> to the USB PHY device.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up for v4.4.
