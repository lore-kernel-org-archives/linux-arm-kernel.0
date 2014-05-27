From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 27 May 2014 09:12:56 +0300
Subject: [GIT PULL] qcom SoC changes for v3.16
In-Reply-To: <538345F0.40605@mm-sol.com>
References: <alpine.DEB.2.00.1405231339340.15680@galak-ubuntu.qualcomm.com>
 <1401108595.6068.5.camel@x220> <538345F0.40605@mm-sol.com>
Message-ID: <1401171176.856.50.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-05-26 at 16:47 +0300, Georgi Djakov wrote:
> On 05/26/2014 03:49 PM, Paul Bolle wrote:
> > On Fri, 2014-05-23 at 13:42 -0500, Kumar Gala wrote:
> >> Ivan T. Ivanov (1):
> >>         ARM: debug: qcom: make UART address selection configuration option
> >
> > This one just landed in linux-next (next-20140526).
> >
> > It removed the Kconfig options DEBUG_MSM_UART1, DEBUG_MSM_UART3, and
> > DEBUG_MSM_UART3. It did not touch these references to their macros:
> >      arch/arm/mach-msm/io.c:60:#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
> >      arch/arm/mach-msm/io.c:61:                defined(CONFIG_DEBUG_MSM_UART3)
> >      arch/arm/mach-msm/io.c:79:#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
> >      arch/arm/mach-msm/io.c:80:                defined(CONFIG_DEBUG_MSM_UART3)
> >
> > Is a patch to fix this queued somewhere?
> >
> 
> Not yet, but I'll send one in a minute.

Right, I have missed this. Thanks.

Ivan
