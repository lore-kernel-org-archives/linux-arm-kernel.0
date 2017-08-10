From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 19:18:09 -0500
Subject: [PATCH 01/13] dt-bindings: update the binding for Allwinner H3
 DE2 support
In-Reply-To: <20170801131304.7741-2-icenowy@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <20170801131304.7741-2-icenowy@aosc.io>
Message-ID: <20170810001809.6xhloimtgwsg5j5d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 09:12:52PM +0800, Icenowy Zheng wrote:
> Allwinner H3 features a "Display Engine 2.0".
> 
> Add device tree bindings for the following parts:
> - H3 TCONs
> - H3 Mixers
> - H3 Display engine
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           | 25 ++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
