From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Feb 2017 15:21:19 +0800
Subject: [PATCH 7/9] ARM: sun5i: a10s: Merge common controllers into the
 common DTSI
In-Reply-To: <8334959b360ad45043703bc128d3d096e33d1bc3.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <8334959b360ad45043703bc128d3d096e33d1bc3.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66cq2L4=amvdiV2630DADKNev7qTXQSc3HD95ppAXKjSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some controllers found in the A10s DTSI actually apply to all of the sun5i
> family. Move those into the common DTSI so that all SoCs can benefit from
> it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
