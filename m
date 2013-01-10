From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 10 Jan 2013 17:32:36 -0500 (EST)
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <CAHkRjk4A+EMFRTVdfCUBNpAEUMWrOqbT2ki19Vska6dY_WrVXQ@mail.gmail.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <CAHkRjk4A+EMFRTVdfCUBNpAEUMWrOqbT2ki19Vska6dY_WrVXQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1301101731430.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jan 2013, Catalin Marinas wrote:

> On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > --- /dev/null
> > +++ b/Documentation/arm/big.LITTLE/cluster-pm-race-avoidance.txt
> > @@ -0,0 +1,498 @@
> > +Big.LITTLE cluster Power-up/power-down race avoidance algorithm
> > +===============================================================
> 
> Nice description and ascii art :).

Credits go to Dave Martin.


Nicolas
