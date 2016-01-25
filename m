From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 25 Jan 2016 10:23:22 -0500 (EST)
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <20160125093114.GA13749@shlinux2>
Message-ID: <Pine.LNX.4.44L0.1601251021250.1849-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jan 2016, Peter Chen wrote:

> Alan, do you know which physical number is larger for
> the same port, HS or SS port? Is it spec defined or vendor defined?
> I haven't found related information at xHCI spec.

I believe it is defined by the vendor.  In fact, I think vendors are 
allowed to number the ports in any order they want, so HS and SS ports 
can be interspersed.  :-)

Alan Stern
