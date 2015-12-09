From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 9 Dec 2015 12:30:30 +0100
Subject: [PATCH) soc: mediatek: scpsys: Add regulator support to power
 domain driver
In-Reply-To: <1448880100-23396-1-git-send-email-s.hauer@pengutronix.de>
References: <1448880100-23396-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <566810D6.30202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/11/15 11:41, Sascha Hauer wrote:
> Some power domains on the MT8173 are supplied by controllable external
> regulators that must be handled properly. This series adds support for
> them.
>
> Sascha
>
> ----------------------------------------------------------------
> Sascha Hauer (2):
>        dt-bindings: soc: Add supplies for Mediatek SCPSYS unit
>        soc: mediatek: SCPSYS: Add regulator support
>
>   .../devicetree/bindings/soc/mediatek/scpsys.txt    | 12 ++++++++++
>   drivers/soc/mediatek/mtk-scpsys.c                  | 27 ++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
>

Applied, thanks a lot.
