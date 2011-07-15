From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Fri, 15 Jul 2011 08:48:54 +0200
Subject: [PATCH 01/52] ARM: introduce atag_offset to replace boot_params
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F383E054DE@AUSP01VMBX24.collaborationhost.net>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<20110708203634.GU4812@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107081714251.14596@xanadu.home>
	<alpine.LFD.2.00.1107111046350.14596@xanadu.home>
	<ADE657CA350FB648AAC2C43247A983F001F383D6D6F7@AUSP01VMBX24.collaborationhost.net>
	<20110712204814.GD15997@ibawizard.net>
	<ADE657CA350FB648AAC2C43247A983F001F383E054DE@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110715064853.GE15997@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten <hartleys@visionengravers.com> [2011-07-12 16:39:47]:

> Could you rebuild your kernel with MACH_EDB9307A also selected in your
> config?  After verifying that it still boots please either send me the zImage
> or place it somewhere I can grab it and I will make sure it boots on mine.

Verified, kernel[1,2] boots. Source tree[3] used to build it (including config etc).

1. http://ynezz.true.cz/redux/zImage 
2. http://ynezz.true.cz/redux/zImage.md5sum 
3. https://github.com/ynezz/linux-2.6/commits/test-redux

-- ynezz
