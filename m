From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 26 Nov 2012 13:47:52 -0500 (EST)
Subject: [PATCH 06/27] usb: host: ehci-mv: fix clk APIs
In-Reply-To: <1353905020-29372-7-git-send-email-xiechao.mail@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1211261346240.2168-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 25 Nov 2012, Chao Xie wrote:

> From: Chao Xie <chao.xie@marvell.com>
> 
> the clock common driver changes, and arch-mmp will make use of
> the common clock driver instead of its own.
> So for enable clock.
> first prepare the clock
> then enable the clock.
> 
> for disable clock
> first disable the clock
> then unprepare the clock
> 
> Signed-off-by: Chao Xie <xiechao.mail@gmail.com>

When you resubmit these patches with the right Signed-off-by: lines,
you can add

Acked-by: Alan Stern <stern@rowland.harvard.edu>

to the ones affecting ehci-mv.c (patches 6, 7, 11, 21, and 27).

Alan Stern
