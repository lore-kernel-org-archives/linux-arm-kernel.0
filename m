From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Jul 2014 08:53:32 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: Add dwc3-st.c file to ARCH/STI
 architecture
In-Reply-To: <53BBA075.9040204@st.com>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-4-git-send-email-peter.griffin@linaro.org>
 <53BBA075.9040204@st.com>
Message-ID: <20140708075332.GM6407@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Jul 2014, Maxime Coquelin wrote:
> On 07/05/2014 08:25 AM, Peter Griffin wrote:
> >Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Maxime,
  Once Acked by Felipe, I think this should go in via your tree to
avoid conflicts with other ARM/STI ARCHITECTURE additions.

> >---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 702ca10..269ad3b 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -1325,6 +1325,7 @@ F:	drivers/pinctrl/pinctrl-st.c
> >  F:	drivers/media/rc/st_rc.c
> >  F:	drivers/i2c/busses/i2c-st.c
> >  F:	drivers/tty/serial/st-asc.c
> >+F:	drivers/usb/dwc3/dwc3-st.c
> >
> >  ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
> >  M:	Lennert Buytenhek <kernel@wantstofly.org>
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
