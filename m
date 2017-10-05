From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:44:42 +0800
Subject: [PATCH 10/20] ARM: dts: sun4i: Rename thermal nodes to avoid
 warnings
In-Reply-To: <f40eebec4a934ee2a2ef46c375c731daac664dba.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <f40eebec4a934ee2a2ef46c375c731daac664dba.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66Fobd6JFqYSnu1LJy4kHQQ7NsXcwgA25jq5crR1yOkeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The thermal-zone subnodes we defined for the A10 have underscores in them
> that will generate DTC warnings. Change those underscores for hyphens.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
