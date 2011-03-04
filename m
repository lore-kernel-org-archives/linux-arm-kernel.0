From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Mar 2011 16:55:14 -0500 (EST)
Subject: [PATCH v5 REPOST 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <87r5amftpx.fsf@ti.com>
References: <1299252837-18074-1-git-send-email-dave.martin@linaro.org>
	<AANLkTimz0Ko9GFtLTcBQVV_c2DAPU5XhV47xT+R9Q7mv@mail.gmail.com>
	<7b1ef0e49e8b8c1c20b0965a58c4fe73@mail.gmail.com>
	<20110304174709.GB20560@atomide.com>
	<AANLkTi=UCk5thBSM_JpFPRAr_POtx-DphP-DrVLBNyMG@mail.gmail.com>
	<87r5amftpx.fsf@ti.com>
Message-ID: <alpine.LFD.2.00.1103041654150.27995@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Mar 2011, Kevin Hilman wrote:

> Dave, just to confirm something The outstanding toolchain bugs only
> affect compiling in Thumb-2 mode, right?  IOW, if I merge just this
> series (without having the other toolchain workaround patches) we should
> still be able to compile/run fine in ARM mode, correct?

Correct.


Nicolas
