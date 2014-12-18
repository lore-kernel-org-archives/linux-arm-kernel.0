From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Dec 2014 09:08:05 +0000
Subject: [STLinux Kernel] [PATCH 6/8] watchdog: st_wdt: Add new driver
 for ST's LPC Watchdog
In-Reply-To: <20141218084314.GA25901@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <1418834727-1602-7-git-send-email-lee.jones@linaro.org>
 <20141218084314.GA25901@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20141218090805.GV13885@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Dec 2014, Peter Griffin wrote:

> Hi Lee,
> 
> On Wed, 17 Dec 2014, Lee Jones wrote:
> 
> > Signed-off-by: David Paris <david.paris@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/watchdog/Kconfig  |  13 ++
> >  drivers/watchdog/Makefile |   1 +
> >  drivers/watchdog/st_wdt.c | 323 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> You don't have a patch which adds the new files created in this series into
> the STI section of the MAINTAINERS file?

Very true.  I will supply one, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
