From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 23:12:31 +0800
Subject: [linux-sunxi] [PATCH v5 4/8] ASoC: sun4i-i2s: Add mclk enable
 regmap field
In-Reply-To: <20170819124839.4034-5-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
 <20170819124839.4034-5-codekipper@gmail.com>
Message-ID: <CAGb2v65pagZHJdgTfezhH5-iYdWS+4FWF9OV8jTCp4YrFNomnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 8:48 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The location of the mclk output enable bit is different on newer
> SoCs. Use a regmap field to enable it.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
