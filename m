From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:54:37 +0800
Subject: [PATCH 15/20] ARM: dts: sun9i: Rename pinctrl nodes to avoid
 warnings
In-Reply-To: <63d98e5495bcfb55d4cce98bcec629dfd3f93cd3.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <63d98e5495bcfb55d4cce98bcec629dfd3f93cd3.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64Ufngnz=ELrx2rVuTh=MPcUbdt_OSSKRU3MhHbVoCkKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Our pinctrl node names were containing unit-adresses without a reg
> property, resulting in a warning. Change the names for our new convention.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
