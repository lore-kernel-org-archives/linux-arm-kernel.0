From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 13:15:53 -0600
Subject: [PATCH v2 10/27] dt-bindings: display: sun4i-drm: Add R40 TV
 TCON description
In-Reply-To: <20180612200036.21483-11-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-11-jernej.skrabec@siol.net>
Message-ID: <20180620191553.GA5151@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 10:00:19PM +0200, Jernej Skrabec wrote:
> TCON description is expanded with R40 TV TCON compatibles. TV TCONs,
> which are connected to TCON TOP muxes, such as those on R40 SoC, also
> needs additional clock gate to be specified.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
