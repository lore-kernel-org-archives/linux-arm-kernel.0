From: horms@verge.net.au (Simon Horman)
Date: Sat, 15 Dec 2012 17:37:39 +0900
Subject: [PATCH 2/7] ARM: mackerel: include the correct .dtsi file
In-Reply-To: <1355503531-7276-3-git-send-email-g.liakhovetski@gmx.de>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-3-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20121215083738.GH9073@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 05:45:26PM +0100, Guennadi Liakhovetski wrote:
> Mackerel's .dts Device Tree description file should derive from the SoC's
> .dtsi, not from skeleton.dtsi directly.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks applied.

I have applied this to a temporary 'boards4' branch which is based on 3.7-rc1.
I will rebase this on 3.8-rc1 once it is released and rename the branch
to the more sane 'boards'.

I have also merged this change into the next branch.
