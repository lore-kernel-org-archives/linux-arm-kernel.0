From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Nov 2012 19:53:10 -0200
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <CALBypN5=vQiPWUpW7ZqgDt+eu4_VpiuUW0heX=vVDKwisXFoBg@mail.gmail.com>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <1352733809-27230-8-git-send-email-s.hauer@pengutronix.de>
 <CALBypN5=vQiPWUpW7ZqgDt+eu4_VpiuUW0heX=vVDKwisXFoBg@mail.gmail.com>
Message-ID: <CAOMZO5CVyC1ZGfiZ1AqeopyLzVhh0bXh9y+ACW5J485Pnn_-1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 7:40 PM, Martin Fuzzey <mfuzzey@gmail.com> wrote:
> Hi Sascha,
>
> On Mon, Nov 12, 2012 at 4:23 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> +               display at di1 {
>> +                       compatible = "fsl,imx-parallel-display";
>> +                       crtcs = <&ipu 1>;
>
> This works but Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
> says "crtc"  (without the s). Looks like the doc has a typo.

Care to send a patch?

Thanks,

Fabio Estevam
