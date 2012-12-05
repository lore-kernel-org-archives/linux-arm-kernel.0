From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 05 Dec 2012 23:28:02 +0000
Subject: [v2 PATCH 02/14] of_spi: add generic binding support to specify
 cs gpio
In-Reply-To: <1354607640-13229-3-git-send-email-wenyou.yang@atmel.com>
References: <1354607640-13229-1-git-send-email-wenyou.yang@atmel.com>
 <1354607640-13229-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20121205232802.ECD2D3E0E22@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Dec 2012 15:53:48 +0800, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> This will allow to use gpio for chip select with no modification in the
> driver binding
> 
> When use the cs-gpios, the gpio number will be passed via the cs_gpio field
> and the number of chip select will automatically increased.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: grant.likely at secretlab.ca
> Cc: rob.herring at calxeda.com
> Cc: rob at landley.net
> Cc: richard.genoud at gmail.com
> ---
> Hi, Richard,
> 
> This patch based on the original patch from Jean-Christophe, 
>  	[PATCH] of_spi: add generic binding support to specify cs gpio
> and merge the patch from Richard Genoud,
> 	[PATCH] [BUG] SPI: array out of bound => no CS
> 
> Could you sign your signature in this patch?
> 
> Best Regards,
> Wenyou Yang

I've already merged a version of this patch. Please check against the
version that is in linux-next.

g.
