From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 14:52:41 -0500
Subject: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
In-Reply-To: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
Message-ID: <20160608195241.GA6805@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
> For different types of SoC the sensor id and endianness may vary.
> "#thermal-sensor-cells" is used to provide sensor id information.
> "little-endian" property is to tell the endianness of TMU.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
> Changes for V2:
> * Remove formatting chnages.
> 
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
