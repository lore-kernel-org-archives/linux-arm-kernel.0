From: davem@davemloft.net (David Miller)
Date: Mon, 23 Jan 2017 16:00:50 -0500 (EST)
Subject: [PATCH v2] net: xilinx: constify net_device_ops structure
In-Reply-To: <1484981938-29829-1-git-send-email-bhumirks@gmail.com>
References: <1484981938-29829-1-git-send-email-bhumirks@gmail.com>
Message-ID: <20170123.160050.47891500917690442.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Sat, 21 Jan 2017 12:28:58 +0530

> Declare net_device_ops structure as const as it is only stored in
> the netdev_ops field of a net_device structure. This field is of type
> const, so net_device_ops structures having same properties can be made
> const too.
> Done using Coccinelle:
 ...
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied.
