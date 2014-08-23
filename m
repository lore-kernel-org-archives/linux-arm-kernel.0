From: olof@lixom.net (Olof Johansson)
Date: Fri, 22 Aug 2014 21:17:34 -0700
Subject: [PATCH 00/11] ARM: multi_v7_defconfig: Enable Zynq/Xilinx drivers
In-Reply-To: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408722876-7791-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140823041734.GA11268@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 08:54:25AM -0700, Soren Brinkmann wrote:
> Hi,
> 
> I went through the defconfig and searched for Zynq drivers. The result is
> this series of patches. The first few are all for Zynq and pretty much
> straight forward. The second half is mostly soft-IP, I think. That
> soft-IP works with Zynq devices, but I'm not sure whether those should
> go into the multi_v7 defconfig.

Thanks, S?ren! 

There's no need to split up into individual patches like this, but it was
convenient in case I wanted to only apply a few of them. I took them all
as one patch, and used your series description as commit message since
none of the individual patches had any. :)

As far as "unusual" drivers in the multiconfig; yeah, we need to deal
with that at some point due to kernel size. We're likely to switch ti
using modules first, but it'll make things slightly more complicated
since people will need to start dealing with initrds and at least I
don't have a good setup for that in my test farm yet. :-)


-Olof
