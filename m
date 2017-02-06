From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Feb 2017 15:22:11 +0800
Subject: [PATCH 8/9] ARM: sun5i: r8: Merge common controllers into the
 common DTSI
In-Reply-To: <8008c3ca3c8451e4f961477ef5c0f4769c65538c.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <8008c3ca3c8451e4f961477ef5c0f4769c65538c.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66ERYR8xmMdeV4jN+FOAx8CXoVc7XBXGgyxLmThyM7nCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some controllers found in the R8 DTSI actually apply to all of the sun5i
> family. Move those into the common DTSI so that all SoCs can benefit from
> it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
