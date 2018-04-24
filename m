From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 11:18:55 +0200
Subject: [PATCH] arm64: dts: renesas: v3msk: add EtherAVB pins
In-Reply-To: <ed7ddd72-4e52-0b2b-d2ef-1d407f638745@cogentembedded.com>
References: <c42c9e9a-8fe8-5cad-0eeb-0c1fbd09f83c@cogentembedded.com>
 <ed7ddd72-4e52-0b2b-d2ef-1d407f638745@cogentembedded.com>
Message-ID: <20180424091855.2ngzbiwvigragk5h@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 02:28:51PM +0300, Sergei Shtylyov wrote:
> On 03/14/2018 11:30 PM, Sergei Shtylyov wrote:
> 
> > Add the (previously omitted) EtherAVB pin data to the V3M Starter Kit
> > board's device tree.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> > The patch is against the 'renesas-devel-20180314-v4.16-rc5' tag of Simon's
> > 'renesas.git repo. It depends on the R8A77970 PFC driver patch adding EtherAVB
> > pin groups (posted yesterday) in order to work properly...
> 
>    The dependency has been now met, please merge this patch.

Thanks, applied.
