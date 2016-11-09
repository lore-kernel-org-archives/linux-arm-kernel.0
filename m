From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:26:29 -0600
Subject: [PATCHv3 1/4] dt-bindings: mfd: Add Altera Arria10 SR Monitor
In-Reply-To: <1478097178-24341-2-git-send-email-tthayer@opensource.altera.com>
References: <1478097178-24341-1-git-send-email-tthayer@opensource.altera.com>
 <1478097178-24341-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20161109182629.2osdnkxavs4ibsnk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 09:32:55AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the Arria10 DevKit System Resource Chip register and state
> monitoring module to the MFD.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> Note: This needs to be applied to the bindings document that
> was Acked & Applied but didn't reach the for-next branch.
> See https://patchwork.ozlabs.org/patch/629397/
> ---
> v2  Change compatible string -mon to -monitor for clarity
> v3  Replace node name a10sr_monitor with just monitor.
>     Replace node name a10sr_gpio with just gpio.
> ---
>  Documentation/devicetree/bindings/mfd/altera-a10sr.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
