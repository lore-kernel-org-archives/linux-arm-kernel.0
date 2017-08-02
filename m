From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 11:55:11 +0800
Subject: [linux-sunxi] [PATCH v3 11/12] ASoC: sun4i-i2s: Update global
 enable with bitmask
In-Reply-To: <20170729141753.20174-12-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-12-codekipper@gmail.com>
Message-ID: <CAGb2v640SbFeMhmfcNdYng=o3QVKZgM=upVmSCZJbsCnm2frUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> The default value of the config register is different on newer
> SoCs and therefore enabling/disabling with a register write
> will clear bits used to set the direction of the clock and frame
> pins.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

This patch looks like it could be applied directly without any
of the other preceding patches?
