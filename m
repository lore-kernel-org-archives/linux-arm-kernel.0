From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 27 May 2015 13:45:22 +0200
Subject: [PATCH 1/3] arm64: dts: mt8173: Add clock controller device nodes
In-Reply-To: <1432128766-4445-2-git-send-email-s.hauer@pengutronix.de>
References: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
 <1432128766-4445-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeKhNuJ4-XSwHTHsK1coUFNbJj-uny9746g8KRZr9t08xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-20 15:32 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> This adds the device nodes providing clocks on the Mediatek MT8173.
> These are: topckgen, infracfg, pericfg and apmixedsys. These are
> fed by two oscillators also added by this patch.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 41 ++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>

Applied, thanks.
Matthias
