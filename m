From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 22:21:17 +0800
Subject: [PATCH 0/12] Add clk_prepare/clk_unprepare for mxs clock api
In-Reply-To: <201112201459.38868.marek.vasut@gmail.com>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <201112201443.03202.marek.vasut@gmail.com>
 <20111220140502.GC5129@S2101-09.ap.freescale.net>
 <201112201459.38868.marek.vasut@gmail.com>
Message-ID: <20111220142116.GA5348@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 02:59:38PM +0100, Marek Vasut wrote:
> Shawn, what exact tree should I use for the test / what branch. I'm slightly 
> confused here. So far, I used next/master since it contained all the stuff I 
> needed (gpmi nand etc).
> 
git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/clk-prepare

It's based on v3.2-rc6, but I guess it can be merged to next/master
without any major problem.

-- 
Regards,
Shawn
