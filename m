From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 27 Oct 2015 18:44:56 +0530
Subject: [PATCH 5/6] ARM: OMAP2+: dts: cm-t335: add support for network
 device
In-Reply-To: <1445948100-16446-6-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1445948100-16446-6-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <562F78D0.5010507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 05:44 PM, Uri Mashiach wrote:
> From: Ilya Ledvich <ilya@compulab.co.il>
> 
> Add pinmux configurations for RGMII1 based CPSW Ethernet pins and
> MDIO pins:
>  - default configuration required for module in active state,
>  - sleep configuration required for module in inactive state.
> Add mac node with single slave device. Add nodes for davinci_mdio and
> cpsw_emac0.
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>

Acked-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
