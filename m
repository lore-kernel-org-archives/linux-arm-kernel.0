From: jrnieder@gmail.com (Jonathan Nieder)
Date: Mon, 18 Mar 2013 15:01:34 -0700
Subject: [PATCH] ARM: video: mxs: Fix mxsfb misconfiguring VDCTRL0
In-Reply-To: <201303182231.22749.marex@denx.de>
References: <1363630997-5254-1-git-send-email-marex@denx.de>
 <20130318185810.GA11040@kroah.com>
 <201303182231.22749.marex@denx.de>
Message-ID: <20130318220134.GC5062@elie.Belkin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut wrote:

>  - It or an equivalent fix must already exist in Linus' tree (upstream).
> This can not happen, the fix in Linus' tree will have to be different since in 
> v3.9 there is one more MX28 platform which also needs fixing. I suppose I will 
> now wait for Shawn to merge the patch for 3.9-rc, get it mainline and then this 
> one can be merged?

Yes, please write again with a patch referencing the upstream commit
id when this has been fixed upstream.

Thanks and hope that helps,
Jonathan
