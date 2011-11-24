From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 15:31:56 +0800
Subject: [PATCH v2 1/1] ASoC: mxs-saif: remove function in platform_data
In-Reply-To: <1321977141-14882-1-git-send-email-b29396@freescale.com>
References: <y>
 <1321977141-14882-1-git-send-email-b29396@freescale.com>
Message-ID: <20111124073155.GH17979@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 11:52:21PM +0800, Dong Aisheng wrote:
> Add master_mode and master_id in platfrom_data since it's board
> specific and board knows it.
> Then we can remove the function pointer in platfrom_data to make
> the driver more devicetree friendly.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
Applied, thanks.

-- 
Regards,
Shawn
