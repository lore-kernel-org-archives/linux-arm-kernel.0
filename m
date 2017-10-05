From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Oct 2017 12:34:24 +0200
Subject: [RESEND][PATCH 4/7] nvmem: imx-ocotp: Move i.MX6 write clock
 setup to dedicated function
In-Reply-To: <1507155921-824-5-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
 <1507155921-824-5-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507199664.8473.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 23:25 +0100, Bryan O'Donoghue wrote:
> The i.MX7S/D has a different set of timing requirements, as a pre-
> cursor to
> adding the i.MX7 timing parameters, move the i.MX6 stuff to a
> dedicated
> function.
> 
> Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
