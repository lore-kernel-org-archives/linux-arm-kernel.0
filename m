From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 23 Nov 2012 11:06:15 -0500 (EST)
Subject: [PATCH 06/29] usb: host: ehci-mv: fix clk APIs
In-Reply-To: <1353549910-988-6-git-send-email-xiechao.mail@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1211231104500.1734-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Nov 2012, Chao Xie wrote:

> From: Chao Xie <chao.xie@marvell.com>
> 
> Signed-off-by: Chao Xie <xiechao.mail@gmail.com>

I don't like patches with no patch description.  You should write 
something here, explaining why the change is needed.  What's wrong with 
the clk APIs?

The same hold for your other patches, except perhaps the trivial one 
that removes an unused local variable definition.

Alan Stern
