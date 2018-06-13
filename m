From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 13 Jun 2018 11:19:59 +0800
Subject: [PATCH v2 02/27] clk: sunxi-ng: r40: Allow setting parent rate to
 display related clocks
In-Reply-To: <20180612200036.21483-3-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-3-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65PyFjC9vQjLj4wGqZ4ETuZd5dF664gwbCRf66=wKOH0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 4:00 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Display related peripherals need precise clocks to operate correctly.
>
> Allow DE2, TCONs and HDMI to set parent clock.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
