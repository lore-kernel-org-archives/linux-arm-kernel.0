From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 26 Apr 2011 10:47:59 +0800
Subject: [PATCH] mmc: sdhci: add support for pre_req and post_req
In-Reply-To: <4DB61F29.4090600@samsung.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
	<BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
	<4DB61F29.4090600@samsung.com>
Message-ID: <20110426024758.GB6145@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 10:26:01AM +0900, Jaehoon Chung wrote:
> Hi Shawn
> 
> I tested using ADMA with your patch...(benchmark : IOzone)
> But I didn't get improvement of performance with ADMA..
> (i can see improvement of performance with SDMA)
> 
> I want to know how you think about this..
> 
It's still an open question if pre_req and post_req were correctly
added, even you have seen improvement of SDMA case with IOzone.  I
would leave the question to Per Forlin.

With your result, I'm interested in trying IOzone test with esdhc
to see any difference with SDMA.

BTW, what is the number of performance improvement you are seeing?
And do you have mmc_test result to share?

-- 
Regards,
Shawn
