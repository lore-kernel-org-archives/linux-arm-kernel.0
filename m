From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 10 May 2016 14:25:38 +0200
Subject: [RFC PATCH 13/21] reset: uniphier: add reset driver for
 UniPhier PH1-LD4 SoC
In-Reply-To: <1462873862-30940-14-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
 <1462873862-30940-14-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462883138.9155.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

Am Dienstag, den 10.05.2016, 18:50 +0900 schrieb Masahiro Yamada:
> This series is just for review.
> Please do not apply this patch.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

No need for all these tiny drivers. If you probe from DT as Lee
requests, you can let of_device_id.data point to a compatible specific
uniphier_reset_data.

regards
Philipp
