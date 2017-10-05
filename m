From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 17:34:01 -0500
Subject: [PATCH v4 11/11] arm: allwinner: Correct unit name in devicetree
 binding example
In-Reply-To: <5b7a8fb3-21bb-417c-9471-1330dd379fd9@rwthex-w2-a.rwth-ad.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
 <5b7a8fb3-21bb-417c-9471-1330dd379fd9@rwthex-w2-a.rwth-ad.de>
Message-ID: <20171005223401.wme5av4hzcc3lzgn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:49:28AM +0200, Stefan Br?ns wrote:
> Unit-names must not start with a leading 0.
> 
> Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
> 
> ---
> 
> Changes in v4:
> - Split minor fix in devicetree example from patch 6/10
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/dma/sun6i-dma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
