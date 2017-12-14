From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 11:44:28 +0800
Subject: [PATCH v4 13/15] ARM: dts: sun8i: a83t: Add the PWM pin group
In-Reply-To: <b58547cd03f88c65162f362361023b44a4b6fc89.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <b58547cd03f88c65162f362361023b44a4b6fc89.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65-Hj55Qg30JSZnPzXzDo3gxGVVqx=D5RSDgejR=5pqYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 11:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A83T has a PWM that can be output from the SoC. Let's add a pinctrl
> group for it.
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Might as well just squash this with patch 11, and enforce it by default.

ChenYu
