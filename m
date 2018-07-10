From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Jul 2018 00:12:45 +0800
Subject: [PATCH 11/17] drm/sun4i: tcon: Add another way for matching
 mixers with tcon
In-Reply-To: <20180706175113.26698-12-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-12-jernej.skrabec@siol.net>
Message-ID: <CAGb2v64-hz6=6H1HhJJogaK8TTtsG4x1LXkA5QX_b3J0pKOAEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Till now, new way of matching engines with TCONs was reading their
> respective ids and match them by those ids. However, with introduction
> of TCON TOP, that might not be so straightforward anymore.
> - there might be more TCONs that engines (mixers)
> - TCON ids might have non-consecutive ids
>
> Workaround that by matching mixer id with TCON index from TCON list.
>
> For example, R40 has 2 mixers and 4 TCONs. Board designer can choose
> 2 outputs, which are connected to any of those 4 TCONs. As long as there
> are only 2 TCONs enabled in DT, using index in list as alternative id,
> will allow to match them with mixer 0 and 1.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
