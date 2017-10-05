From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:53:33 +0800
Subject: [PATCH 18/20] ARM: dts: sun9i: cubieboard4: Remove card detect
 pull-up
In-Reply-To: <efb84cd6e7d9685042a1dbeb80a5e89ff123cd7e.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <efb84cd6e7d9685042a1dbeb80a5e89ff123cd7e.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66tZiVx2uCOr7xV23HwxZvdPs7FfwYeeFw5Jj3h7ezi1A@mail.gmail.com>
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
