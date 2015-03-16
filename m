From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Mar 2015 08:17:16 +0000
Subject: [PATCH v5 02/10] mfd: syscon: Add atmel system timer registers
 definition
In-Reply-To: <550315C7.7010403@atmel.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1426162054-9987-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20150313080315.GC3383@x1> <20150313104032.GG4329@piout.net>
 <550315C7.7010403@atmel.com>
Message-ID: <20150316081716.GF3383@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Mar 2015, Nicolas Ferre wrote:

> Le 13/03/2015 11:40, Alexandre Belloni a ?crit :
> > Hi,
> > 
> > On 13/03/2015 at 08:03:15 +0000, Lee Jones wrote :
> >> On Thu, 12 Mar 2015, Alexandre Belloni wrote:
> >>
> >>> AT91RM920 has a memory range reserved for timer and watchdog configuration.
> >>> Expose those registers so that drivers can make use of the system timer syscon
> >>> declared in at91 DTs.
> >>>
> >>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>> Acked-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>>  include/linux/mfd/syscon/atmel-st.h | 49 +++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 49 insertions(+)
> >>>  create mode 100644 include/linux/mfd/syscon/atmel-st.h
> >>
> >> Applied, thanks.
> 
> > Actually, I was thinking this could go through the at91 to avoid
> > depending on your branch.
> 
> Lee,
> 
> I was planning to take the whole series with me to limit the number of
> merge conflicts and dependencies.
> Do you mind if I take this patch with the other AT91 cleanup patches
> through the arm-soc tree?
> If you are okay, can you remove this patch already applied on your tree?

Yes, no problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
