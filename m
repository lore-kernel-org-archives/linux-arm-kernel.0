From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 10:32:12 +0800
Subject: [PATCH v3 21/24] drm: of: Export drm_crtc_port_mask()
In-Reply-To: <20180625120304.7543-22-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-22-jernej.skrabec@siol.net>
Message-ID: <CAGb2v66vEJZijF82u6cKf3j0J678=kNCCps5+=oj7iHCzM9n6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Function is useful when drm_of_find_possible_crtcs() can't be used and
> custom parsing is needed. This can happen for example when there is a
> node with multiple muxes between crtc and encoder.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
