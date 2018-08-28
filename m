From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 28 Aug 2018 11:04:47 -0400 (EDT)
Subject: [PATCH 00/14] Convert ehci-mv to DT
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <Pine.LNX.4.44L0.1808281104250.1443-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2018, Lubomir Rintel wrote:

> Hi,
> 
> This patch set makes it possible to use the Marvell EHCI driver with
> DT-based machines.
> 
> Tested on a marvell,mmp2-based OLPC XO 1.75 laptop. (With a custom
> appended DT that will be submitted in a separate patch set. The
> machine's OpenFirmware provides a device tree, but that one is too
> buggy to boot a pure marvell,mmp2 FDT kernel.)

For all the EHCI parts of this series:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
