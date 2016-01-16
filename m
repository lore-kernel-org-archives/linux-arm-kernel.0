From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Jan 2016 01:12:37 +0800
Subject: [PATCH v2 12/26] ARM: sun5i: Add TV encoder gate to the DTSI
In-Reply-To: <1452785109-6172-13-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-13-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64Ae0bUgFZ2q21-n67sUNFfMtxruMiEE1R18xw+Lp-Gqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 11:24 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> It turns out that the A13 / R8 also have a tve encoder block, and a gate
> for it.
>
> Add it to the DT.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  arch/arm/boot/dts/sun5i-a13.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

[...]
