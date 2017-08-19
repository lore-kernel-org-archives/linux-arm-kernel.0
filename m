From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 22:49:38 +0800
Subject: [linux-sunxi] [PATCH v5 3/8] ASoC: sun4i-i2s: bclk and lrclk
 polarity tidyup
In-Reply-To: <20170819124839.4034-4-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
 <20170819124839.4034-4-codekipper@gmail.com>
Message-ID: <CAGb2v65GxWCWAvFEVH8UJqhbHm5ANOWP-Ef2fHqw3aMtW6XW1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 8:48 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On newer SoCs the bit fields for the blck and lrclk polarity are in
> a different locations. Use regmap fields to set the polarity bits
> as intended.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
