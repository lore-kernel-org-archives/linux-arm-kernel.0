From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 1 Aug 2017 16:10:45 +0800
Subject: [linux-sunxi] [PATCH v3 03/12] ASoC: sun4i-i2s: Add regmap config
 to quirks
In-Reply-To: <20170729141753.20174-4-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-4-codekipper@gmail.com>
Message-ID: <CAGb2v649V0fscBbmYLjQOhh2Uw3FHSo+Q694vz0jSg5_RBe=cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The newer SoCs have a larger range than the original SoC that this
> driver was developed for. By adding the regmap config to the quirks
> then the driver can initialise the managed register map correctly.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
