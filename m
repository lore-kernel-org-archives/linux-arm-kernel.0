From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:22:32 +0800
Subject: [PATCH 02/20] ARM: dts: axp209: Rename usb_power_supply node to
 avoid warnings
In-Reply-To: <b00bd68196621f396076dbdc5e84e3d59e558953.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <b00bd68196621f396076dbdc5e84e3d59e558953.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67wtgZyNdooTPv3QxT76WNfPF_+AoHdf02GZsoaKtAGNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The USB power supply node in the AXP209 DTSI is using underscores in its
> node name, which is generating a warning. Change those underscores for
> hyphens.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
