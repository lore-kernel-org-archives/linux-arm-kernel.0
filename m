From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Mar 2017 19:31:05 -0500
Subject: [PATCH v3 04/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
In-Reply-To: <20170321153611.16228-5-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-5-quentin.schulz@free-electrons.com>
Message-ID: <20170329003105.keybmgnknzgtywys@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:36:04PM +0100, Quentin Schulz wrote:
> This patch adds documentation for the A33 GPADC binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> v3:
>   - fixed missing allwinner in front of compatible,
>   - updated compatible to allwinner,sun8i-a33-ths to better reflect the
>   datasheet's name,
>   - updated example's DT node name and label to ths,
> 
> added in v2
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

If you respin, "dt-bindings: mfd: ..." for the subject.

Acked-by: Rob Herring <robh@kernel.org>
