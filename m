From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 23:42:43 +0100
Subject: [PATCH 05/12] clk: SPEAr13xx: Fix pcie clock name
In-Reply-To: <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <aeeefe3537089f0d0a2f8f5662d50dfca2aadf29.1386752447.git.mohit.kumar@st.com>
Message-ID: <201312112342.43840.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> Follow dt clock naming convention for PCIe clocks.
> 

I think in the future, the spear clocks really need to get
moved into DT representations, as we do for other platforms,
which will get rid of a lot of code in drivers/clk, including
all the clkdev registration.

	Arnd
