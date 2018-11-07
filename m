From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 7 Nov 2018 09:50:57 +0100
Subject: [PATCH V3] arm64: dts: r8a77990: ebisu: Add and enable SDHI
 device nodes
In-Reply-To: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
References: <20181106204647.18051-1-marek.vasut+renesas@gmail.com>
Message-ID: <20181107085056.GB31092@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 09:46:47PM +0100, Marek Vasut wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds SDHI{0,1,3} device nodes for the r8a77990 SoC
> and enables SD card slot connected to SDHI0, micro SD card slot
> connected to SDHI1 and eMMC connected to SDHI3 on the Ebisu board
> using the R8A77990 SoC.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Out of curiosity: have you tested HS400 on that board based on Niklas'
recent patches as well?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181107/2d5d77be/attachment.sig>
