From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 1 Dec 2016 23:37:19 +0100
Subject: [PATCH v7 3/4] arm64: dts: marvell: Add I2C definitions for the
 Armada 3700
In-Reply-To: <20161201110440.27530-4-romain.perier@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-4-romain.perier@free-electrons.com>
Message-ID: <20161201223719.GD19261@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:04:39PM +0100, Romain Perier wrote:
> The Armada 3700 has two i2c bus interface units, this commit adds the
> definitions of the corresponding device nodes. It also enables the node
> on the development board for this SoC.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

This needs to go via arm-soc.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/1638dc2e/attachment.sig>
