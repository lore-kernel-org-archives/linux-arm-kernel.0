From: davem@davemloft.net (David Miller)
Date: Wed, 23 May 2018 16:08:11 -0400 (EDT)
Subject: [PATCH V4 0/8] net: ethernet: stmmac: add support for stm32mp1
In-Reply-To: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
References: <1527090479-5263-1-git-send-email-christophe.roullier@st.com>
Message-ID: <20180523.160811.1425159248399846750.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christophe Roullier <christophe.roullier@st.com>
Date: Wed, 23 May 2018 17:47:51 +0200

> Patches to have Ethernet support on stm32mp1
> Changelog:
> Remark from Rob Herring
> Move Documentation/devicetree/bindings/arm/stm32.txt in 
> Documentation/devicetree/bindings/arm/stm32/stm32.txt and create
> Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
> 
> Replace also in arch/arm/boot/dts/stm32mp157c.dtsi, syscfg: system-config at 50020000 
> with syscfg: syscon at 50020000syscfg: system-config at 50020000 

Probably the DTS file updates need to go in via the ARM tree, not
mine.

Can you respin a net-next targetted series that has just the driver
code and device tree binding updates?

Thank you!
