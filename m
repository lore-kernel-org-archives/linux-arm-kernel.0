From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 13:14:32 -0600
Subject: [PATCH v9 3/8] ASoC: dt-bindings: add regulator property to
 simple amplifier
In-Reply-To: <20181122102325.29495-4-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-4-wens@csie.org>
Message-ID: <20181126191432.GA30762@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2018 18:23:20 +0800, Chen-Yu Tsai wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Amplifier may have associated regulator, so add a property for it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/sound/simple-amplifier.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
