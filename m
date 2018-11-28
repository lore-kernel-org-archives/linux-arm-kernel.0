From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:35:14 +0800
Subject: [PATCH 57/77] ARM: dts: sun8i: a23/a33: Change framebuffer node
 names to avoid warnings
In-Reply-To: <5581c89e3dc87081d16f869b0340cc5d62865965.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <5581c89e3dc87081d16f869b0340cc5d62865965.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65_eSspMBj52_49V0jve-Sk4VDiBp=-qbxQ0VeyTAKFWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The simple-framebuffer nodes have a unit address, but no reg property which
> generates a warning when compiling it with DTC.
>
> Change the simple-framebuffer node names so that there is no warnings on
> this anymore.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
