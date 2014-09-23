From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 14:38:39 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <1411474536-22626-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411474536-22626-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <51745791.Wuu5QiQB2e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 14:15:30 Antoine Tenart wrote:
> +Optional properties:
> +- port-id: should be '0','1' or '2'.
> +- phy-addr: MDIO address of the PHY.
> +- local-mac-address: see ethernet.txt file in the same directory.
> +
> 

I believe new bindings should not use "phy-addr" properties, but
instead use a phy-handle property pointing to a phy device instead.

The port-id property description could be a little more verbose.
What do those numbers actually mean?

	Arnd
