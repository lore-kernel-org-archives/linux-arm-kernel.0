From: robh@kernel.org (Rob Herring)
Date: Tue, 10 Oct 2017 13:56:56 -0500
Subject: [PATCH v2 1/4] dt-bindings: nvmem: Describe the Amlogic
 Meson6/Meson8/Meson8b efuse
In-Reply-To: <20171002232804.20042-2-martin.blumenstingl@googlemail.com>
References: <20171002232804.20042-1-martin.blumenstingl@googlemail.com>
 <20171002232804.20042-2-martin.blumenstingl@googlemail.com>
Message-ID: <20171010185656.pf4jybiohcywp7wj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 01:28:01AM +0200, Martin Blumenstingl wrote:
> Amlogic Meson6, Meson8 and Meson8b SoCs have an efuse which contains
> calibration data from the factory (for the internal temperature sensor
> and some CVBS connector settings). Some manufacturers also store the MAC
> address or serial number in the efuse.
> 
> This documents the devicetree bindings for the efuse on these SoCs.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/nvmem/amlogic-meson-mx-efuse.txt      | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/amlogic-meson-mx-efuse.txt

Acked-by: Rob Herring <robh@kernel.org>
