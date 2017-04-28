From: robh@kernel.org (Rob Herring)
Date: Fri, 28 Apr 2017 12:13:37 -0500
Subject: [PATCH v2 3/5] mtd: gpmi: document current clock requirements
In-Reply-To: <20170422012338.4635-4-stefan@agner.ch>
References: <20170422012338.4635-1-stefan@agner.ch>
 <20170422012338.4635-4-stefan@agner.ch>
Message-ID: <20170428171337.23jti5634myafw65@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 06:23:36PM -0700, Stefan Agner wrote:
> The clock requirements are completely missing, add the clocks
> currently required by the driver.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/mtd/gpmi-nand.txt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
