From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:51:15 +0800
Subject: [PATCH 14/20] ARM: dts: sun9i: Remove skeleton to avoid warnings
In-Reply-To: <3c127ab5cd3ef874a51d9e8b37277fb87e7f774f.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <3c127ab5cd3ef874a51d9e8b37277fb87e7f774f.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65jFsZ+hn3VJBJ_3y38KTuf20PiQnO+3Z9YdeX4WnLXmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Using skeleton.dtsi will create a memory node that will generate a warning
> in DTC. However, that node will be created by the bootloader, so we can
> just remove it entirely in order to remove that warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
