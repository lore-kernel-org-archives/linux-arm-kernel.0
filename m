From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 09:57:38 +0800
Subject: [linux-sunxi] [PATCH v3 07/24] drm/sun4i: Split out code for
 enumerating endpoints in output port
In-Reply-To: <20180625120304.7543-8-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-8-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66xYd1cCN7M82HvEovCkVdidsC7ceDbUhiPcy-otPLTHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Until now, each node has one input port and one output port. However,
> with TCON TOP this is no longer true. It has 3 input and 3 output ports.
>
> In order to prepare to this situation, split out the code which checks
> all endpoints in input port and adds available components to fifo.
>
> This patch doesn't do any functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
