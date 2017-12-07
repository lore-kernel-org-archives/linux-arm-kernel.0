From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 7 Dec 2017 11:34:56 +0800
Subject: [PATCH v3 14/15] ARM: dts: sun8i: a711: Reinstate the PMIC
 compatible
In-Reply-To: <25b482f19587ff195582995c11ee9d07f5bf42d2.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <25b482f19587ff195582995c11ee9d07f5bf42d2.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65Lr9Bqja00gHVY0kvzGMOXMCzU2g2UX226KwXvhDBRvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 11:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> When we added the regulator support in commit 90c5d7cdae64 ("ARM: dts:
> sun8i: a711: Add regulator support"), we also dropped the PMIC's
> compatible. Since it's not in the PMIC DTSI, unlike most other PMIC
> DTSI, it obviously wasn't probing anymore.
>
> Re-add it so that everything works again.
>
> Fixes: 90c5d7cdae64 ("ARM: dts: sun8i: a711: Add regulator support")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
