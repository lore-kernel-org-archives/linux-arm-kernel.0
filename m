From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 20:01:58 +0800
Subject: [PATCH 2/6] ASoC: mxs: use devm_clk_get for mxs_saif_probe
In-Reply-To: <20120510093032.GI3908@opensource.wolfsonmicro.com>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
 <20120510091332.GF3908@opensource.wolfsonmicro.com>
 <CAAQ0ZWRtwwpToK9J5EbJvRrKnzGn6SrkDgNumat1b3vAS4ytUw@mail.gmail.com>
 <20120510093032.GI3908@opensource.wolfsonmicro.com>
Message-ID: <20120510120156.GJ17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 10:30:33AM +0100, Mark Brown wrote:
> Well, if Russell's happy with that being merged into other trees I could
> just pull it into ASoC?  Or we could just wait, or if this is really
> separate to everything else why not just apply it on the clkdev branch
> rather than worrying about some complicated arrangement?
> 
> This is just a trivial cleanup to use new APIs...

Ok, giving up ...

-- 
Regards,
Shawn
