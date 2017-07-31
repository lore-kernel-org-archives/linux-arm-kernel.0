From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Jul 2017 13:39:01 +0800
Subject: [PATCH 2/4] clk: sunxi-ng: multiplier: Fix fractional mode
In-Reply-To: <20170730164150.26302-3-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
 <20170730164150.26302-3-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66_p1kuuU8ZmA=q3O3o342qmcgL6Ny=VEsYg+jksApqKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
<jernej.skrabec@siol.net> wrote:
> Driver for multiplier clock is missing a call to
> ccu_frac_helper_enable() when fractional mode is selected.
>
> Add a call to ccu_frac_helper_enable().
>
> Fixes: d77e8135b340 ("clk: sunxi-ng: multiplier: Add fractional support")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued as a fix for 4.13.

ChenYu
