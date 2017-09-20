From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Sep 2017 10:07:13 -0400 (EDT)
Subject: [PATCH v1] usb: host: Implement workaround for Erratum A-007463
In-Reply-To: <20170920092441.21292-1-yinbo.zhu@nxp.com>
Message-ID: <Pine.LNX.4.44L0.1709201004040.1563-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Subject: line should specify which type of USB host controller the
patch is for.  The kernel contains lots of different USB host
controller drivers.  How are we supposed to know that Erratum A-007463
applies to dwc3 xHCI controllers?

The Subject: line should say something like:

[PATCH v1] USB: host: dwc3: Implement workaround for Erratum A-007643

Alan Stern
