From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Mon, 12 Nov 2012 22:40:48 +0100
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CALBypN5=vQiPWUpW7ZqgDt+eu4_VpiuUW0heX=vVDKwisXFoBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Nov 12, 2012 at 4:23 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> +               display at di1 {
> +                       compatible = "fsl,imx-parallel-display";
> +                       crtcs = <&ipu 1>;

This works but Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
says "crtc"  (without the s). Looks like the doc has a typo.

I ran into that problem today on i.MX53

Regards,

Martin
