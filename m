From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:31:40 -0600
Subject: [PATCH] dt-bindings: rockchip-dw-mshc: use consistent clock names
In-Reply-To: <20180301103447.7059-1-john@metanate.com>
References: <20180301103447.7059-1-john@metanate.com>
Message-ID: <20180307193140.gbccxsp3rxanxjpp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 10:34:47AM +0000, John Keeping wrote:
> The names of these clocks are "ciu-drive" and "ciu-sample" as described
> for the clock-names property.  Avoid confusion by spelling these
> correctly everywhere they are referenced.
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
