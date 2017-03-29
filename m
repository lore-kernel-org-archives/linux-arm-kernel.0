From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 29 Mar 2017 10:12:01 +0200
Subject: [PATCH] reset: uniphier: add NAND and eMMC reset control
In-Reply-To: <1490690408-2616-1-git-send-email-yamada.masahiro@socionext.com>
References: <1490690408-2616-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1490775121.2274.29.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-03-28 at 17:40 +0900, Masahiro Yamada wrote:
> Add reset lines for the Denali NAND controller on all UniPhier SoCs,
> for the Cadence eMMC controller on LD11/LD20 SoCs.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Philipp,
> 
> Sorry for sending this in the last minute.
> If it is not too late, please apply this for 4.12-rc1.
> Thanks!

I've applied it to reset/next, will send another pull request at the end
of the week.

regards
Philipp
