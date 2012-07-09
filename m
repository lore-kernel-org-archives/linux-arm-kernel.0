From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 22:23:14 +0800
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207091150.10910.marex@denx.de>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <201207091046.36886.marex@denx.de>
 <20120709090239.GH11635@S2101-09.ap.freescale.net>
 <201207091150.10910.marex@denx.de>
Message-ID: <20120709142312.GB18874@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 11:50:10AM +0200, Marek Vasut wrote:
> But almost every board needs that hack ... won't it be easier to make it into 
> default behavior? Or can we not somehow configure this via DT itself?
> 
Yeah, after adopting clock DT bindings, we can make it via DT.

-- 
Regards,
Shawn
