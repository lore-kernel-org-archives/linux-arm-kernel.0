From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 May 2017 11:10:19 +0800
Subject: [linux-sunxi] [PATCH v6 06/13] drm/sun4i: add a dedicated module
 for sun4i-backend and sun4i-layer
In-Reply-To: <20170504114858.9008-7-icenowy@aosc.io>
References: <20170504114858.9008-1-icenowy@aosc.io>
 <20170504114858.9008-7-icenowy@aosc.io>
Message-ID: <CAGb2v67s4qZL7yDfZWjsno7KZzhAMsXcKLwX8ciBhrUfFNT7BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 7:48 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Currently the direct call from CRTC code to layer code has disappeared,
> instead the layer's init function is called via the backend's ops.
>
> Add a dedicated module for sun4i-backend and sun4i-layer, and drop the
> EXPORT_SYMBOL from backend code to layer code.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
