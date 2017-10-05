From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:53:20 +0800
Subject: [PATCH 17/20] ARM: dts: sun9i: optimus: Remove card detect pull-up
In-Reply-To: <62c6ed04912e6b3ea3f7e37a09d0e102033b00e6.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <62c6ed04912e6b3ea3f7e37a09d0e102033b00e6.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65LQrMRhKnyxDgkMGmDN7PowWTZrfGCNqu3bwW118XxVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The board has an external pull-up on the card-detect signal, so there's no
> need to add another one.
>
> This also removes a DTC warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
