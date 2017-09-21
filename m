From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 18:12:40 -0500
Subject: [PATCH] nvmem: sunxi-sid: add support for A64/H5's SID controller
In-Reply-To: <20170918154204.54427-1-icenowy@aosc.io>
References: <20170918154204.54427-1-icenowy@aosc.io>
Message-ID: <20170921231240.tsoapk6zlwcysiud@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 11:42:04PM +0800, Icenowy Zheng wrote:
> Allwinner A64/H5 SoCs come with a SID controller like the one in H3, but
> without the silicon bug that makes the initial value at 0x200 wrong, so
> the value at 0x200 can be directly read.
> 
> Add support for this kind of SID controller.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>  drivers/nvmem/sunxi_sid.c                                       | 6 ++++++
>  2 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
