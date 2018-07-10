From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:20:30 +0800
Subject: [PATCH 01/17] dt-bindings: display: sun4i-drm: Add R40 display
 engine compatible
In-Reply-To: <20180706175113.26698-2-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-2-jernej.skrabec@siol.net>
Message-ID: <CAGb2v6556Gqs0H+L7W1oiyevep8aTwMWJs8ipBOcX+-=BdNYfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:50 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 has pretty unique display pipeline. It supports two outputs at the
> same time.
>
> Possible outputs:
> - 1x HDMI,
> - 2x TV output
> - 1x VGA,
> - 1x MIPI DSI and
> - 2x LCD outputs
>
> That is the biggest number of possible outputs from all Allwinner SoC.
> Because of that, add new compatible for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
