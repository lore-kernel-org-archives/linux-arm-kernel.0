From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:23:43 +0800
Subject: [PATCH 04/20] ARM: dts: sun4i: Change clock node names to avoid
 warnings
In-Reply-To: <7fe9d6db8d10c8e062eb41bffb9be40c67ce0fa5.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <7fe9d6db8d10c8e062eb41bffb9be40c67ce0fa5.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64_-cMSQD_goANzSYmVZeYEpcEv3NE4ZKtFbq-9UkGuXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Our oscillators clock names have a unit address, but no reg property, which
> generates a warning in DTC. Change these names to remove those unit
> addresses.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
