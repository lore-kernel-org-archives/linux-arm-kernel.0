From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 13:16:36 -0600
Subject: [PATCH v2 16/27] dt-bindings: display: sun4i-drm: Add R40 mixer
 compatibles
In-Reply-To: <20180612200036.21483-17-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-17-jernej.skrabec@siol.net>
Message-ID: <20180620191636.GA6106@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 10:00:25PM +0200, Jernej Skrabec wrote:
> R40 DE2 mixers are similar to those found in A83T, except it needs
> different clock settings.
> 
> Add a compatibles for them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
