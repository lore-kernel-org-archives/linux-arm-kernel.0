From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 13:40:19 -0500
Subject: [PATCH 1/2] dt-bindings: Document the Broadcom STB wake-up timer
 node
In-Reply-To: <20170615195904.12653-2-f.fainelli@gmail.com>
References: <20170615195904.12653-1-f.fainelli@gmail.com>
 <20170615195904.12653-2-f.fainelli@gmail.com>
Message-ID: <20170623184019.ftptqodyv3bnkyz2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 12:59:03PM -0700, Florian Fainelli wrote:
> Document the binding for the Broadcom STB SoCs wake-up timer node
> allowing the system to generate alarms and exit low power states.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/rtc/brcm,brcmstb-waketimer.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/brcm,brcmstb-waketimer.txt

Acked-by: Rob Herring <robh@kernel.org>
