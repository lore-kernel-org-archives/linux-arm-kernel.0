From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 17 Mar 2015 15:02:12 -0400 (EDT)
Subject: [PATCH 2/5] USB: host: ohci-at91: remove useless uclk clock
In-Reply-To: <1426608950-31555-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1503171501110.1061-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015, Boris Brezillon wrote:

> Now that the system clock driver is forwarding set_rate request to the
> parent clock, we can safely call clk_set_rate on the system clk and get
> rid of the uclk field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
