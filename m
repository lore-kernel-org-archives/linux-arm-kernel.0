From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:21:07 +0800
Subject: [PATCH 03/17] ARM: dts: sun8i: r40: Remove fallback display
 engine compatible
In-Reply-To: <20180706175113.26698-4-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-4-jernej.skrabec@siol.net>
Message-ID: <CAGb2v67NgyW8ATtfS_abjYhLkRa8L-cJZ5=xHurZ+tJJ=0uijg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:50 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 has pretty unique display pipeline. Because of that, H3 display
> engine compatible fallback should be removed.
>
> Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
