From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 9 Nov 2009 00:05:31 +0000
Subject: [PATCH] Update Samsung S5PC100 SoC support
In-Reply-To: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091109000531.GH4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:05AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> This patch series updates Samsung S5PC100 SoC support. S5PC100 platform
> core has been extended with new clocks hierarchy implementation, gpio lib,
> support for external and gpio interrupts and some basics of power
> management (cpu idle and system reset). Also platform helpers for
> s3c framebuffer, i2c and hsmmc drivers has been added.
> 
> All these patches has been tested on SMDKC100 board.

Apart from the problems with sign-offs/authors on these patches, they
seem to be mostly fine. My only concern is the LCD header files and
I will try and revist these before the next merge window is upon us.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
