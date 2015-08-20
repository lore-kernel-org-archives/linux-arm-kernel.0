From: davem@davemloft.net (David Miller)
Date: Thu, 20 Aug 2015 14:05:31 -0700 (PDT)
Subject: [PATCH v1 0/6] Add fec1 and fec2 support for i.MX7d sdb board
In-Reply-To: <1439962444-27486-1-git-send-email-b38611@freescale.com>
References: <1439962444-27486-1-git-send-email-b38611@freescale.com>
Message-ID: <20150820.140531.1320709021949935376.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fugang Duan <b38611@freescale.com>
Date: Wed, 19 Aug 2015 13:33:58 +0800

> The patch series is to add fec support for i.MX7d sdb board. Since i.MX7d fec ip is
> the same as i.MX6SX, so there have no change for driver itself.
> 
> Patch#1: add bcm54220 PHY ID entry into brcmphy.h file.

This is completely, and utterly, pointless.

The only reason a PHY ID should be defined in brcmphy.h is so that it can
be used in the broadcom.c PHY driver or similar.

If there is no user in the tree, there is no reason to add it to the
header file.
