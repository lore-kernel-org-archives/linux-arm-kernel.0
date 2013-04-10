From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 09:41:52 +0900
Subject: [PATCH 1/2] ARM: shmobile: R8A7778: fix Ether device name
In-Reply-To: <201304092147.51621.sergei.shtylyov@cogentembedded.com>
References: <201304092147.51621.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130410004151.GC2462@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 09:47:51PM +0400, Sergei Shtylyov wrote:
> While recasting the commit "ARM: shmobile: R8A7778: add Ether support", I made a
> typo in the platform device's name: used underscore instead of hyphen. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is atop of the 'renesas-next-20130410' tag of the 'renesas.git' tree.

Thanks, queued up in the soc-r7a7778 branch.
