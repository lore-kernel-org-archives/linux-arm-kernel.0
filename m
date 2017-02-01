From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Feb 2017 11:26:29 -0600
Subject: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
In-Reply-To: <20170131100552.27949-2-mylene.josserand@free-electrons.com>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
Message-ID: <20170201172629.6hcabndljh4bwm5p@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl?ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
> 
> This new compatible, "allwinner,sun6i-a31-i2s", requires the
> property "resets" which should be a phandle to the reset line.
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/sound/sun4i-i2s.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
