From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Jul 2017 13:02:18 +0800
Subject: [PATCH 4/4] clk: sunxi-ng: Wait for lock when using fractional
 mode
In-Reply-To: <20170730164150.26302-5-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
 <20170730164150.26302-5-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66FAYtsp39+5Aj2oZfyo=O=R1GJ11w3-vmJOysezsvcYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
<jernej.skrabec@siol.net> wrote:
> Currently ccu_frac_helper_set_rate() doesn't wait for a lock bit to be
> set before returning. Because of that, unstable clock may be used.
>
> Add a wait for lock in the helper function.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Can you provide a Fixes: tag?

Otherwise this looks good.
