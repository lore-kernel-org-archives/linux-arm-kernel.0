From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 14:52:49 +0000
Subject: [PATCH 1/4] ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
In-Reply-To: <b2e8f9f71001221447r7feb098fx2e5b06126c1556da@mail.gmail.com>
References: <b2e8f9f71001221447r7feb098fx2e5b06126c1556da@mail.gmail.com>
Message-ID: <20100126145249.GD9153@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2010 at 11:47:08PM +0100, Maurus Cuelenaere wrote:
> ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
> 
> This moves mach-s3c2410/include/mach/ts.h to plat-samsung/include/plat/ts.h in
> order to prepare for s3c64xx support in the touchscreen driver.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

git rename detection please.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
