From: robh@kernel.org (Rob Herring)
Date: Tue, 2 Feb 2016 16:43:48 -0600
Subject: [PATCH 02/11] mfd: axp20x: Add bindings for AXP809 PMIC
In-Reply-To: <1454408864-24112-3-git-send-email-wens@csie.org>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-3-git-send-email-wens@csie.org>
Message-ID: <20160202224348.GA15250@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 06:27:35PM +0800, Chen-Yu Tsai wrote:
> This patch adds the basic and regulator bindings for the X-Powers AXP809
> PMIC.
> 
> Also update the DC-DC converter operating frequency for AXP22X/AXP80X.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 31 ++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
