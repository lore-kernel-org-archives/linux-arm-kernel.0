From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 18:35:13 +0800
Subject: [linux-sunxi] [PATCH v3 03/12] dt-bindings: make AXP20X
 compatible strings one per line
In-Reply-To: <20170417115747.7300-4-icenowy@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-4-icenowy@aosc.io>
Message-ID: <CAGb2v65upOLfpWCy74zWYZZtobqjX30cJerJSv1q-70+9ipK+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 7:57 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> In the binding documentation of AXP20X mfd, the compatible strings used
> to be listed for three per line, which leads to some mess when trying to
> add AXP803 compatible string (as we have already AXP806 and AXP809
> compatibles, which is after AXP803 in ascending order).
>
> Make the compatible strings one per line, so that inserting a new
> compatible string will be directly a new line.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Chen-Yu Tsai <wens@csie.org>
