From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Jul 2016 10:49:06 +0900
Subject: [PATCH v2] ARM: dts: r8a7794: Correct SDHI register size
In-Reply-To: <20160721062849.GD1664@katana>
References: <1469058248-27880-1-git-send-email-horms+renesas@verge.net.au>
 <20160721062849.GD1664@katana>
Message-ID: <20160722014906.GF21943@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 08:28:50AM +0200, Wolfram Sang wrote:
> On Thu, Jul 21, 2016 at 08:44:08AM +0900, Simon Horman wrote:
> > r8a7794 SDHI ch0 has SD_DMACR which is located in 0x324.
> > This patch updates register size
> > 
> > Based on work for the r8a7790 by Kuninori Morimoto.
> > 
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queue this up for v4.9.
