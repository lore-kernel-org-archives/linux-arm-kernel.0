From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 Sep 2016 14:23:29 +0000
Subject: [PATCH] dt-bindings: mvebu-odmi: fix example typo
In-Reply-To: <0743fef6fe390bc4ae7cabd15c4836bbed98f7cf.1473087913.git.baruch@tkos.co.il>
References: <0743fef6fe390bc4ae7cabd15c4836bbed98f7cf.1473087913.git.baruch@tkos.co.il>
Message-ID: <20160906142328.GS10637@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Mon, Sep 05, 2016 at 06:05:13PM +0300, Baruch Siach wrote:
> Make the example compatible string match its definition.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../bindings/interrupt-controller/marvell,odmi-controller.txt           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to irqchip/mvebu64 with Thomas' Reviewed-by.

thx,

Jason.
