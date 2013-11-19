From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Nov 2013 11:08:03 +0900
Subject: [PATCH] ARM: shmobile: Enable GPIO LEDs on Genmai
In-Reply-To: <20131119020424.GH17628@verge.net.au>
References: <20131113234230.1579.9739.sendpatchset@w520>
 <20131119020424.GH17628@verge.net.au>
Message-ID: <20131119020802.GI17628@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:04:25AM +0900, Simon Horman wrote:
> On Thu, Nov 14, 2013 at 08:42:30AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Enable led1 and led2 on the Genmai board using
> > the r7s72100 SoC and the GPIO RZ driver.
> 
> Thanks, I have queued this up.

I was a little to hasty. I have unqueued this patch
as it depends on "ARM: shmobile: r7s72100 GPIO DT nodes for GPIO RZ"
which appears to still be under discussion.

> 
> I think there should be an accompanying defconfig update.
> Would you like me to prepare something?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
