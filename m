From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Jun 2018 09:57:10 +0800
Subject: [PATCH v3 08/24] drm/sun4i: Add support for traversing graph with
 TCON TOP
In-Reply-To: <20180625120304.7543-9-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
 <20180625120304.7543-9-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65+L9rTFZ4+zNXvCX4=Ni8mHzkFYCPK2GcBmTELh34Ojw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TCON TOP is different from other nodes in graph by having 3 input and 3
> output ports. Additionally, connection to TV TCON might lead back to
> HDMI mux input port, creating loops.
>
> Add support for traversing such graph.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
