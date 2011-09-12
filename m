From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 Sep 2011 13:27:50 +0800
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <CACRpkdZvb_y6m-uiFu-wMt5XR-UcZGRWUDGrgMFJ9ySzj6VAOA@mail.gmail.com>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<CACRpkdZvb_y6m-uiFu-wMt5XR-UcZGRWUDGrgMFJ9ySzj6VAOA@mail.gmail.com>
Message-ID: <20110912052749.GD1258@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 09:19:03AM +0200, Linus Walleij wrote:
> On Tue, Sep 6, 2011 at 7:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > The patch removes __init annotation from a few initialization
> > functions to make the reinitialization possible. ?For example,
> > platform resume function can call l2x0_of_init() to get L2 cache
> > back to work.
> 
> This will collide with patch 7080/1:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7080/1
> 
> Before you put it into the patch tracker can you please rebase it
> on that patch and also remove the __init tag from the
> l2x0_unlock() function?
> 
Yes, will do, if rmk asks me to put the patch into patch tracker.

-- 
Regards,
Shawn
