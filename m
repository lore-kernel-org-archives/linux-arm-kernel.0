From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 3 Jan 2018 13:46:14 +0800
Subject: [PATCH 02/11] clk: sunxi-ng: a83t: Add M divider to TCON1 clock
In-Reply-To: <20171230210203.24115-3-jernej.skrabec@siol.net>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <20171230210203.24115-3-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64x8UqBNc1asw0oiudwLoebp0yGomY9W9LbnCTKW-HViQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 31, 2017 at 5:01 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TCON1 also has M divider, contrary to TCON0.
>
> Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Added "And the mux is only 2 bits wide, instead of 3." to the commit
message and applied.

ChenYu
