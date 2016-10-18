From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 09:05:48 -0500
Subject: [PATCH 1/4] dt-bindings: mfd: Add Altera Arria10 SR Monitor
In-Reply-To: <1476394329-31696-2-git-send-email-tthayer@opensource.altera.com>
References: <1476394329-31696-1-git-send-email-tthayer@opensource.altera.com>
 <1476394329-31696-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20161018140548.su5ffrjqrxlk4cyf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2016 at 04:32:06PM -0500, tthayer at opensource.altera.com wrote:
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
> ---
>  .../devicetree/bindings/mfd/altera-a10sr.txt       |    9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
