From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 6 Aug 2017 10:01:39 +0800
Subject: [linux-sunxi] [PATCH 1/2] mmc: sunxi: fix support for new timings
 mode only SoCs
In-Reply-To: <20170804213555.6024-1-icenowy@aosc.io>
References: <20170804213555.6024-1-icenowy@aosc.io>
Message-ID: <CAGb2v66j-EFZ6P5uAXwtJB-+tMv0NSa2XS6QMm_B9GrDA3CzJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 5, 2017 at 5:35 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The A83T MMC support code introduces the timings mode switch, however
> such a switch doesn't exist on new SoCs with only new timings mode.
>
> Only execute the switch if the SoC really have the timings mode switch,
> to fix the regression shown on new timings mode only SoCs (A64, H5,
> etc).
>
> Fixes: b0600daebf31 ("mmc: sunxi: Support controllers that can use both
> old and new timings")

You could make it easier to read by aligning the wrapped line with
opening parenthesis and double quote.

And you don't need the newline here.

>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This must have slipped through when I reworked the mmc quirks.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
