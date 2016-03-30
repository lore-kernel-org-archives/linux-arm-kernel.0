From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Mar 2016 19:43:14 +0800
Subject: ARM: dts: imx6ul: add more functionality to i.MX6UL
In-Reply-To: <1457095043-14115-1-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1453284549-16363-1-git-send-email-LW@KARO-electronics.de>
 <1457095043-14115-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160330114313.GE28207@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 01:37:21PM +0100, Lothar Wa?mann wrote:
> [PATCHv3 1/2] ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL modules
> [PATCHv3 2/2] ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL mainboard

Applied both, thanks.

> 
> This patchset adds more functionality to the i.MX6UL machines.
> 
> Changes vs. v1:
> - added patch to implement KPP clock for i.MX6UL to prevent conflicts
>   when this patch would go via a different tree.
> - added board support for Ka-Ro electronics TX6UL module for the same
>   reason
> - added imx6ul specific compatibles as requested by Lucas Stach
> 
> Changes vs. v2:
> - dropped patches which have already been applied in the meantime
> - addressed comments by Shawn Guo
> 
> 
