From: davem@davemloft.net (David Miller)
Date: Thu, 20 Oct 2016 14:41:40 -0400 (EDT)
Subject: [PATCH 0/4] STM32F429: Add Ethernet fixes
In-Reply-To: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
References: <1476976886-23781-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <20161020.144140.1794871934594140769.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre TORGUE <alexandre.torgue@st.com>
Date: Thu, 20 Oct 2016 17:21:22 +0200

> This series adds several fixes for Ethernet for stm32f429 MCU.
> First 2 patches have already been reviewed some months ago when 
> stm32 Ethernet glue has been pushed (I added in this series to keep
> history). Fixes are:
>  -Change DT to be compliant to stm32 ethernet glue binding
>  -Add phy-handle to correctly use mdio subnode
>  -Remove WoL support

I'm assuming this will be merged via the ARM tree.
