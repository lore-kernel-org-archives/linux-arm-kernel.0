From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 Feb 2018 10:55:35 +0800
Subject: [PATCH] ASoC: sun4i-i2s: Fix RX slot number of SUN8I
In-Reply-To: <1519613032-10244-1-git-send-email-yong.deng@magewell.com>
References: <1519613032-10244-1-git-send-email-yong.deng@magewell.com>
Message-ID: <CAGb2v65-Gz8jarHMpKS+S7rNRkknBPF5qV5VCSpeDYQG7woVDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 10:43 AM, Yong Deng <yong.deng@magewell.com> wrote:
> I2S's RX slot number of SUN8I should be shifted 4 bit to left.
>
> Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
