From: andy@warmcat.com (Andy Green)
Date: Wed, 09 Mar 2011 15:18:11 +0000
Subject: [PATCH 2 14/18] I2C: OMAP1/OMAP2+: create omap I2C functionality
	flags for each cpu_... test
In-Reply-To: <AANLkTi=KjWq9B9Bt90Th72=tXF2BfEv1p1Z-0=Sk1Z+t@mail.gmail.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>	<20110308110904.23531.66727.stgit@otae.warmcat.com>
	<AANLkTi=KjWq9B9Bt90Th72=tXF2BfEv1p1Z-0=Sk1Z+t@mail.gmail.com>
Message-ID: <4D779A33.9070905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2011 02:31 PM, Somebody in the thread at some point said:

Hi -

> Minor comment, Can you use
> BIT(0) for 1, BIT(1) for 2 ... BIT (8) for 0x100

OK, I agree it will be nicer.  Thanks for the comment.

I guess I can just change this and issue just this guy as try 3 rather 
than sending the whole series mostly unchanged.  In that case, I'll take 
care of Benoit's member re-ordering to match the scripts at the same 
time and issue that guy as try 3 as well.

-Andy
