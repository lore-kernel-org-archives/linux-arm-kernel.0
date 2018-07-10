From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 00:16:15 +0800
Subject: [PATCH 15/17] ARM: dts: sun8i: r40: Disable TCONs by default.
In-Reply-To: <20180706175113.26698-16-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-16-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64=Mzwz6eZxvHO6XuCNa5XQcQDt8HkOrFqRO8MXTVSRjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 has 4 TCONs, but only 2 of them can receive some kind of output at
> the same time. Let's disable them by default, so only those which are
> really connected on board can be enabled in board dts file.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Originally I had wanted all TCONs enabled by default. But that would
require some more work for dynamic assignment of TCONs to CRTCs, which
is way out of scope for this series. So,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I'll think about if and how this could be done.
