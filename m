From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 14:52:46 -0500
Subject: [PATCH 1/3] dt-bindings: Amlogic: add documentation for the SoC
 info register areas
In-Reply-To: <20170923141403.20882-2-martin.blumenstingl@googlemail.com>
References: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
 <20170923141403.20882-2-martin.blumenstingl@googlemail.com>
Message-ID: <20171005195246.6nddrovf53zenxxo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 23, 2017 at 04:14:01PM +0200, Martin Blumenstingl wrote:
> There are three register areas which contain information about the SoC
> version and revision:
> - the assist registers contain the SoC's "major version" which encodes
>   the SoC generation and part number. this is available on Meson6,
>   Meson8 and Meson8b SoCs.
> - the bootrom register contains at least the SoCs "misc version". this
>   is avilable on Meson6, Meson8 and Meson8b
> - the analog top registers contain information about the SoC revision.
>   this is only available on Meson8 and Meson8b
> 
> Not much else is currently known about these registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/arm/amlogic/analog-top.txt   | 20 ++++++++++++++++++++
>  .../devicetree/bindings/arm/amlogic/assist.txt       | 17 +++++++++++++++++
>  .../devicetree/bindings/arm/amlogic/bootrom.txt      | 17 +++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/analog-top.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/assist.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/bootrom.txt

Acked-by: Rob Herring <robh@kernel.org>
