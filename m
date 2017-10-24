From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 11:28:47 -0500
Subject: [PATCH 03/10] drm/sun4i: hdmi: Support HDMI controller on A10
In-Reply-To: <20171017121807.2994-4-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-4-wens@csie.org>
Message-ID: <20171024162847.hk7hnoikz5eu7aol@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 08:18:00PM +0800, Chen-Yu Tsai wrote:
> The HDMI controller in the A10 SoC is the same as the one currently
> supported in the A10s. It has slightly different setup parameters.
> Since these parameters are not thoroughly understood, we add support
> for this variant by copying these parameters verbatim.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt           |  1 +
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 53 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
