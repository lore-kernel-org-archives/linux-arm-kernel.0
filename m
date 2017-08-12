From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Aug 2017 19:44:45 +0800
Subject: [linux-sunxi] [PATCH v3 01/11] ASoC: sun4i-i2s: Add clkdiv
 offsets to quirks
In-Reply-To: <20170812110059.5115-2-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
 <20170812110059.5115-2-codekipper@gmail.com>
Message-ID: <CAGb2v66LA2=6nxzGpqrdd0SePz73VinXy2TDW8=GNK3VZa7Z_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 7:00 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The BCLKDIV and MCLKDIV found on newer SoCs start from an offset of 1.
> Add the functionality to adjust the division values according to the
> needs to the device being used.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
