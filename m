From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 22 Jan 2014 16:17:42 -0500 (EST)
Subject: [PATCH 2/2] ehci-platform: Add support for controllers with
 big-endian regs / descriptors
In-Reply-To: <20140122213434.00000f25@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1401221614550.1310-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jan 2014, Jonas Gorski wrote:

> If it's safe to set ehci->big_endian_{desc,mmio} from the _probe()
> routine, then maybe the pdata sets in _reset() should be moved into here
> instead of adding extra cludges/checks into _reset().

Why?  What difference would it make?

Alan Stern
