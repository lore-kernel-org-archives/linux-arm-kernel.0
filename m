From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 23 Jun 2015 21:36:32 +0200
Subject: [PATCH 1/3] arm64: dts: mt8173: Add clock controller device nodes
In-Reply-To: <1432128766-4445-2-git-send-email-s.hauer@pengutronix.de>
References: <1432128766-4445-1-git-send-email-s.hauer@pengutronix.de>
 <1432128766-4445-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <7038138.YVtZV1WZ5z@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 20, 2015 03:32:44 PM Sascha Hauer wrote:
> This adds the device nodes providing clocks on the Mediatek MT8173.
> These are: topckgen, infracfg, pericfg and apmixedsys. These are
> fed by two oscillators also added by this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 41
> ++++++++++++++++++++++++++++++++ 1 file changed, 41 insertions(+)

Applied now to v4.2-next/arm64
