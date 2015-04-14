From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 14 Apr 2015 10:41:29 -0400 (EDT)
Subject: [PATCHv2 2/3] usb: ehci-platform: Use devm_of_phy_get_by_index
In-Reply-To: <1428963047-23666-3-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <Pine.LNX.4.44L0.1504141040340.1370-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Apr 2015, Arun Ramamurthy wrote:

> Getting phys by index instead of phy names so that we do
> not have to create a naming scheme when multiple phys
> are present
> 
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

You have not responded to the comments I posted earlier:

	http://marc.info/?l=linux-usb&m=142798455925594&w=2

Alan Stern
