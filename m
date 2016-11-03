From: davem@davemloft.net (David Miller)
Date: Thu, 03 Nov 2016 16:02:44 -0400 (EDT)
Subject: [PATCH v5 0/7] add NS2 support to bgmac
In-Reply-To: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
References: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <20161103.160244.678792221354219550.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jon.mason@broadcom.com>
Date: Wed,  2 Nov 2016 13:08:01 -0400

> Add support for the amac found in the Broadcom Northstar2 SoC to the
> bgmac driver.  This necessitates adding support to connect to an
> externally defined phy (as described in the device tree) in the driver.
> These phy changes are in addition to the changes necessary to get NS2
> working.

This does not apply cleanly to the net-next, please respin.
