From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 21 May 2014 18:28:06 +0300
Subject: [PATCH v1 4/4] ARM: debug: qcom: Add APQ8084 DEBUG_LL UART support
In-Reply-To: <4365639.JcFl1cP048@wuerfel>
References: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
 <1400684225-21381-5-git-send-email-gdjakov@mm-sol.com>
 <4365639.JcFl1cP048@wuerfel>
Message-ID: <1400686086.856.15.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Wed, 2014-05-21 at 17:18 +0200, Arnd Bergmann wrote:
> On Wednesday 21 May 2014 17:57:05 Georgi Djakov wrote:

> >  
> > +#ifdef CONFIG_DEBUG_APQ8084_UART
> > +#define MSM_DEBUG_UART_BASE    0xFA75E000
> > +#define MSM_DEBUG_UART_PHYS    0xF995E000
> > +#endif
> > +

> Maybe we should move debug/msm.S over to use
> CONFIG_DEBUG_UART_PHYS/CONFIG_DEBUG_UART_VIRT now?
> 

There is patch which do this [1]. It was reviewed 
by Stephen Boyd [2].

Regards,
Ivan


[1] https://lkml.org/lkml/2014/4/14/312
[2] https://lkml.org/lkml/2014/4/14/542
