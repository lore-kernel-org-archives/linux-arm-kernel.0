From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 13 Feb 2017 23:04:22 +0800
Subject: [linux-sunxi] [PATCH 1/8] dt-bindings: fix for Allwinner H5
 pinctrl's compatible
In-Reply-To: <20170208100009.29362-1-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
Message-ID: <CAGb2v65DEiE7wGqFiUqte_zvQEu+KGwLFc6GxG0RE4pRBo7mTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 6:00 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:
> The compatible for Allwinner H5 pin controller is wrong written as
> allwinner,sun50i-h5-r-pinctrl, however, it's really a generic pinctrl
> rather than a "r" one.
>
> Fix this compatible string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Chen-Yu Tsai <wens@csie.org>
