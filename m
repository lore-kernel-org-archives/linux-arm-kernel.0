From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 9 Jul 2015 14:03:58 -0700
Subject: [RFT PATCH] net: axienet: Fix devm_ioremap_resource return value
 check
In-Reply-To: <1436448080-24775-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1436448080-24775-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150709210358.GG3129@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-07-09 at 10:21PM +0900, Krzysztof Kozlowski wrote:
> Value returned by devm_ioremap_resource() was checked for non-NULL but
> devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
> error this could lead to dereference of ERR_PTR.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 46aa27df8853 ("net: axienet: Use devm_* calls")
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
