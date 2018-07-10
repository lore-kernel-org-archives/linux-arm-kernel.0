From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 00:09:47 +0800
Subject: [PATCH 17/17] dt-bindings: display: sun4i-drm: Fix order of DW
 HDMI PHY compatibles
In-Reply-To: <20180706175113.26698-18-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-18-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65x3CBw009gFTH-DmAFjfX_xSbSzOXLWbkyJU1PQ1yD+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> They are currently sorted alphabetically. However, they should be sorted
> by release date of the family and then alphabetically.
>
> Fixes: 03c35dbf73e0 ("dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
