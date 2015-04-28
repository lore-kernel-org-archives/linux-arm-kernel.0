From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Apr 2015 08:59:15 +0800
Subject: [PATCH] ARM: imx: Constify irq_domain_ops
In-Reply-To: <1430139099-3673-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430139099-3673-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150428005914.GC18776@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 09:51:39PM +0900, Krzysztof Kozlowski wrote:
> The irq_domain_ops are not modified by the driver and the irqdomain core
> code accepts pointer to a const data.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Applied, thanks.
