From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 6 Oct 2017 16:34:26 +0800
Subject: [PATCH 3/3] pinctrl: sunxi: Enforce the strict mode by default
In-Reply-To: <817a66704d6c8f3caa034a526db11e25a9152a65.1507236823.git-series.maxime.ripard@free-electrons.com>
References: <cover.7a61d0bb31530def29efd8b4286d8c0afdaab347.1507236823.git-series.maxime.ripard@free-electrons.com>
 <817a66704d6c8f3caa034a526db11e25a9152a65.1507236823.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64FwRnthfP=OrxUp92oAtozzo6BEAOFbn8pMg5gXUpWjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 4:54 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The strict mode should always have been enabled on our driver, and leaving
> it unchecked just makes it harder to find a migration path as time passes.
>
> Let's enable it by default now so that hopefully the new SoCs should be
> safe.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
