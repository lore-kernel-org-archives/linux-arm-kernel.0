From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 13 Jun 2016 16:33:04 +0200
Subject: [PATCH v2 2/4] ARM: dts: r8a7790: lager: use demuxer for IIC1/I2C1
In-Reply-To: <1465370066-8450-3-git-send-email-horms+renesas@verge.net.au>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160613143304.GC1603@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 04:14:24PM +0900, Simon Horman wrote:
> Make it possible to select which I2C1 IP core you want to run on the
> EXIO-A connector.
> 
> This is based on reference work for the I2C0 core of the lager by Wolfram Sang.
> 
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Given the PFC problem gets solved, why can't you switch to GP1_16 and
GP1_17 for those?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/05e2de2d/attachment.sig>
