From: amit.kucheria@canonical.com (Amit Kucheria)
Date: Tue, 9 Feb 2010 18:06:31 +0200
Subject: [PATCHv3 5/7] mxc: Add support for the Babbage board (i.MX5)
In-Reply-To: <4B6C5519.2070506@gmail.com>
References: <cover.1265385421.git.amit.kucheria@canonical.com>
	<367110fafb57f7340bbffec9b394ed2fa6e89da5.1265385421.git.amit.kucheria@canonical.com>
	<553d86cf968ba78a26b67098c2e1849407a51ba1.1265385421.git.amit.kucheria@canonical.com>
	<bf84de08e5c511325fb94a742f5d6efabece06b6.1265385421.git.amit.kucheria@canonical.com>
	<7739120baf6088e426f3f8bab174f6c6a6df3601.1265385421.git.amit.kucheria@canonical.com>
	<ef6149ed5e1d228262c3d98421a836400095c1b7.1265385421.git.amit.kucheria@canonical.com>
	<4B6C5519.2070506@gmail.com>
Message-ID: <20100209160631.GI3390@matterhorn.verdurent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Feb 05, Magnus Lilja wrote:
> Amit Kucheria skrev:
> > Babbage is a reference board from Freescale for their i.MX51 SoC.
> > 
> > Add board definition, Kconfig and Makefiles to enable Freescale i.MX51
> > processor and Babbage board.
> > 
> > Boot tested on a Babbage2.5 board
> 
> In u-boot this board, and the files, are called mx51evk instead of Babbage. It would be nice if the same name is used in both, but no big issue.
> 
> Regards, Magnus

I started to do a patch to move it to EVK but then realised that
arch/arm/tools/mach-types has it as mx51_babbage. So this would cause more
confusion.

I'll just add a comment in the Kconfig help.

Regards,
Amit
-- 
----------------------------------------------------------------------
Amit Kucheria, Kernel Engineer || amit.kucheria at canonical.com
----------------------------------------------------------------------
