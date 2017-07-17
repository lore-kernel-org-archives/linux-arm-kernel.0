From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 17 Jul 2017 12:55:59 +0300
Subject: [PATCH] pinctrl: zte: fix 'functions' allocation in
 zx_pinctrl_build_state()
In-Reply-To: <20170717094622.GE3172@dragon>
References: <1500212008-29321-1-git-send-email-shawnguo@kernel.org>
 <20170717080221.gqf7xgeo2zqgigdq@mwanda>
 <20170717094622.GE3172@dragon>
Message-ID: <20170717095559.oatvwvhnrzg2hd3m@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 05:46:24PM +0800, Shawn Guo wrote:
> On Mon, Jul 17, 2017 at 11:02:21AM +0300, Dan Carpenter wrote:
> > Shouldn't there be a free if the remove function?  I'm not even sure
> > where the remove function is so I don't know.
> 
> As the pinctrl driver is essential for the platform, it's always a
> builtin_platform_driver which we do not even have a remove function.
> 

Ah.  Good deal, then.

regards,
dan carpenter
