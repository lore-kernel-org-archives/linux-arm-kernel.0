From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 2 Jun 2017 08:53:19 -0700
Subject: [PATCH v7 0/3] Support for USB DRD Phy driver for NS2
In-Reply-To: <1496408439-30431-1-git-send-email-raviteja.garimella@broadcom.com>
References: <1496408439-30431-1-git-send-email-raviteja.garimella@broadcom.com>
Message-ID: <4824c415-ea31-f252-7e94-ed3e3b2c064c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/02/2017 06:00 AM, Raviteja Garimella wrote:
> 
> Raviteja Garimella (3):
>   dt-bindings:phy:Add DT bindings documentation for NS2 USB DRD phy
>   phy:phy-bcm-ns2-usbdrd:Broadcom USB DRD Phy driver for Northstar2
>   arm64: dts: NS2: Add USB DRD PHY device tree node

For future submission can you be consistent in how you create your
subjects and how PHY vs. Phy or phy is used? For instance this would be
much better:

dt-bindings: phy: Add DT bindings documentation for NS2 USB DRD PHY
phy: phy-bcm-ns2-usbdrd: Broadcom USB DRD PHY driver for Northstar 2

Thank you
-- 
Florian
