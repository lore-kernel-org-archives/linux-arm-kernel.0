From: saeed.bishara@gmail.com (saeed bishara)
Date: Thu, 18 Mar 2010 15:42:25 +0200
Subject: Highmem issues with MMC filesystem
In-Reply-To: <20100318112453.GA19544@n2100.arm.linux.org.uk>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
Message-ID: <c70ff3ad1003180642n1d9410a9g35c24b06df6afef0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In no case does the kernel ever clean user space cache lines for DMA;
> that's not the responsibility of the DMA API.
I understand that it's not the DMA API's responsibility to flush user
space cache lines, but other parts of the kernel should do that right?
otherwise DIRECT_IO won't work (though the issue here has nothing to
do with DIRECT_IO).

saeed
