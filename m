From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 10 Jul 2018 23:53:55 +0800
Subject: [PATCH 14/17] ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON
 connections
In-Reply-To: <20180706175113.26698-15-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
 <20180706175113.26698-15-jernej.skrabec@siol.net>
Message-ID: <CAGb2v6442VWvuWnK1JCnxNqwRhp6pS+tVZkaRfs6xjYYxTRwfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Current R40 is missing some graph connections between TCON TOP and
> TCONs.
>
> Add them.
>
> Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
