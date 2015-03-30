From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Mar 2015 12:37:51 +0100
Subject: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci and
 emmc.
In-Reply-To: <20150330112357.GE21893@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
 <54F594F8.50306@st.com>
 <20150330112357.GE21893@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150330113751.GE9447@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Mar 2015, Peter Griffin wrote:

> Hi Maxime,
> 
> On Tue, 03 Mar 2015, Maxime Coquelin wrote:
> 
> > 
> > On 02/26/2015 02:10 PM, Peter Griffin wrote:
> > >The nodes have been split to allow as much commonality as possible.
> > >The stih407 has a silicon bug with eMMC UHS modes (with top regs)
> > >and as such doesn't have any of the uhs dt properties.
> > >
> > >Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > >---
> > >  arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
> > >  arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
> > >  arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
> > >  3 files changed, 48 insertions(+)
> > >
> > >
> > Maybe you could also add SD/eMMC support to the b2199 too?
> 
> Yes ok, I will add support for stih418-b2199 in v3.

Is there any reason why this can't be actioned in a subsequent patch?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
