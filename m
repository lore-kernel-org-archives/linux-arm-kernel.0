From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 00:36:04 -0500
Subject: [PATCHv2 1/4] dt-bindings: mfd: Add Altera Arria10 SR Monitor
In-Reply-To: <1477598426-28125-2-git-send-email-tthayer@opensource.altera.com>
References: <1477598426-28125-1-git-send-email-tthayer@opensource.altera.com>
 <1477598426-28125-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20161031053604.3rjbuk7maabzbwq7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 03:00:23PM -0500, tthayer at opensource.altera.com wrote:
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
> ---
>  Documentation/devicetree/bindings/mfd/altera-a10sr.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
> index ea151f2..c47be28 100644
> --- a/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
> +++ b/Documentation/devicetree/bindings/mfd/altera-a10sr.txt
> @@ -18,6 +18,7 @@ The A10SR consists of these sub-devices:
>  Device                   Description
>  ------                   ----------
>  a10sr_gpio               GPIO Controller

This should be just "gpio" BTW.

> +a10sr_monitor            Register and State Monitoring

s/_/-/ or maybe just "monitor". Not really a generic node name to use 
for this.

Rob
