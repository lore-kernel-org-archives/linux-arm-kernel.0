From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:49:50 +0800
Subject: [PATCH 13/17] ARM: dts: sun8i: r40: Remove fallback compatible
 for TCON TV
In-Reply-To: <20180706175113.26698-14-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-14-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64E-mzbf0gL91=51ZfTrb=+8QwNr1SXMi8Vj547jC4t9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> While registers between A83T and R40 TV TCON are the same, R40 TCON TV
> driver has to set additional muxes in TCON TOP. Because of that, remove
> fallback A83T TCON TV compatible.

Nit: device tree doesn't care about the implementation. You can however
mention that hardware interaction makes it not so compatible. :)

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
