From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:44:00 +0800
Subject: [PATCH 72/77] ARM: dts: sun8i: v3s: Remove skeleton and memory to
 avoid warnings
In-Reply-To: <3d2df36c4b2e62efd774ff40449b359992e55ebb.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <3d2df36c4b2e62efd774ff40449b359992e55ebb.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65rsUXpx2Swoq3Tyn4y2z-eRTvPNQyerWmaWJ_QStVRSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our memory node will generate a warning in DTC since the unit address is
> not matching the reg property. However, that node will be created by the
> bootloader, so we can just remove it entirely in order to remove that
> warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
