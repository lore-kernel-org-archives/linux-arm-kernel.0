From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 19 Feb 2014 16:12:38 +0100
Subject: [PATCH v3 15/15] mfd: max14577: Add device tree bindings document
In-Reply-To: <1392627950-26927-16-git-send-email-k.kozlowski@samsung.com>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
 <1392627950-26927-16-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5304C9E6.9060705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 17.02.2014 10:05, Krzysztof Kozlowski wrote:
> Add document describing device tree bindings for MAX14577 MFD
> drivers: MFD core, extcon, regulator and charger.
>
> Both MAX14577 and MAX77836 chipsets are documented.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>   Documentation/devicetree/bindings/mfd/max14577.txt |  149 ++++++++++++++++++++
>   1 file changed, 149 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
