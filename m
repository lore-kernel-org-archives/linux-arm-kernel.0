From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Jul 2018 17:15:06 -0600
Subject: [PATCH v3 3/4] nvmem: sunxi-sid: add support for H5's SID
 controller
In-Reply-To: <20180727115205.20955-3-manu@freebsd.org>
References: <20180727115205.20955-1-manu@freebsd.org>
 <20180727115205.20955-3-manu@freebsd.org>
Message-ID: <20180730231506.GA8608@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 01:52:04PM +0200, Emmanuel Vadot wrote:
> The H5 SoC have a SID controller that looks like the one in A64, the
> cells are in the same offset but doesn't contain the same data (thermal
> sensor calibration for example).
> Add a binding for it.
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
