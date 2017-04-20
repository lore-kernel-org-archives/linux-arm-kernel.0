From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Apr 2017 18:03:30 +0900
Subject: [PATCH] arm64: dts: m3ulcb: Fix EthernetAVB PHY timing
In-Reply-To: <a7afb651-d103-248c-5610-2fc41a773c52@cogentembedded.com>
References: <1492477578-10228-1-git-send-email-horms+renesas@verge.net.au>
 <a7afb651-d103-248c-5610-2fc41a773c52@cogentembedded.com>
Message-ID: <20170420090330.GI3760@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 12:26:25PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 4/18/2017 4:06 AM, Simon Horman wrote:
> 
> >Set PHY rxc-skew-ps to 1500 and all other values to their default values.
> >
> >This is intended to to address failures in the case of 1Gbps communication
> >using the by salvator-x board with the KSZ9031RNX phy. This has been
> 
>    The by? :-)
> 
> >reported to occur with both the r8a7795 (H3) and r8a7796 (M3-W) SoCs.
> >
> >Based in a similar patch for the r8a7796 salvator-x by Kazuya Mizuguchi.
> >
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> [...]

Thanks, I have queued this up with the typo fixed.
