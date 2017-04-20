From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 09:05:54 -0500
Subject: [PATCH v4 03/11] dt-bindings: add bindings for DE2 on V3s SoC
In-Reply-To: <20170416120849.54542-4-icenowy@aosc.io>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-4-icenowy@aosc.io>
Message-ID: <20170420140554.f5squ3uqah3dfvlv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 16, 2017 at 08:08:41PM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC have a display engine which have a different pipeline
> with older SoCs.
> 
> Add document for it (new compatibles and the new "mixer" part).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Removed the refactor at TCON chapter.
> 
> Changes in v3:
> - Remove the description of having a BE directly as allwinner,pipeline.
> 
>  .../bindings/display/sunxi/sun4i-drm.txt           | 29 ++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
