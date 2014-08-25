From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 25 Aug 2014 07:42:07 -0700
Subject: [PATCH 00/11] ARM: multi_v7_defconfig: Enable Zynq/Xilinx drivers
In-Reply-To: <20140823041734.GA11268@localhost>
References: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140823041734.GA11268@localhost>
Message-ID: <09383930-0cc9-490e-be4e-e45cc9a31041@BN1BFFO11FD016.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-22 at 09:17PM -0700, Olof Johansson wrote:
> On Fri, Aug 22, 2014 at 08:54:25AM -0700, Soren Brinkmann wrote:
> > Hi,
> > 
> > I went through the defconfig and searched for Zynq drivers. The result is
> > this series of patches. The first few are all for Zynq and pretty much
> > straight forward. The second half is mostly soft-IP, I think. That
> > soft-IP works with Zynq devices, but I'm not sure whether those should
> > go into the multi_v7 defconfig.
> 
> Thanks, S?ren! 
> 
> There's no need to split up into individual patches like this, but it was
> convenient in case I wanted to only apply a few of them. I took them all
> as one patch, and used your series description as commit message since
> none of the individual patches had any. :)

Yeah, that was my thinking. It's easier to squash things than splitting.
Thanks for taking it.

> 
> As far as "unusual" drivers in the multiconfig; yeah, we need to deal
> with that at some point due to kernel size. We're likely to switch ti
> using modules first, but it'll make things slightly more complicated
> since people will need to start dealing with initrds and at least I
> don't have a good setup for that in my test farm yet. :-)

I agree. Monolithic kernels make those things a lot easier.

	Thanks,
	S?ren
