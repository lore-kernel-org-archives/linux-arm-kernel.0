From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Jun 2014 14:53:02 +0100
Subject: Add SDHCI support for STMicroelectronics SoCs
In-Reply-To: <20140602102930.GB437@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
 <537E1B55.1090807@st.com>
 <20140602102930.GB437@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20140602135302.GB4146@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >Initially it supports the stih416 and stih415 SoCs, and has
> > >been tested on a stih416-b2020 board.
> > 
> > In next version, could you also add  drivers/mmc/host/sdhci-st.c in
> > the ARM/STI ARCHITECTURE field of MAINTAINERS file?
> 
> Was out on hols last week. I have fixed it in v2.

This should be in its own patch.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
