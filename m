From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Jun 2015 13:13:03 -0700 (PDT)
Subject: [PATCH 1/4] soc: mediatek: Add infracfg misc driver support
In-Reply-To: <1435126625-9634-2-git-send-email-s.hauer@pengutronix.de>
References: <1435126625-9634-1-git-send-email-s.hauer@pengutronix.de>
 <1435126625-9634-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <6508444.knfrqRFL7c@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 24, 2015 08:17:02 AM Sascha Hauer wrote:
> This adds support for some miscellaneous bits of the infracfg controller.
> The mtk_infracfg_set/clear_bus_protection functions are necessary for
> the scpsys power domain driver to handle the bus protection bits which
> are contained in the infacfg register space.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to v4.2-next/soc
