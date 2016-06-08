From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 8 Jun 2016 10:05:16 +0200
Subject: [PATCH v2 4/4] ARM: dts: r8a7790: lager: use demuxer for IIC3/I2C3
In-Reply-To: <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
References: <1465370066-8450-1-git-send-email-horms+renesas@verge.net.au>
 <1465370066-8450-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160608080516.GI1521@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 04:14:26PM +0900, Simon Horman wrote:
> Create a separate bus for dla98063 PMIC and da9210 regulator
> related I2C slaves.
> 
> Based on similar work for HDMI by Wolfram Sang.
> 
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Maybe add a word that PFC doesn't allow I2C0/I2C3 to be muxed as GPIO?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/122eef7c/attachment.sig>
