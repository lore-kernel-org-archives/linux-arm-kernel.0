From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Wed, 15 Jan 2014 16:37:58 -0800 (PST)
Subject: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
In-Reply-To: <CANqRtoQ8sLLXQWKHaxbFpSb+3oBF2Spn_nUZx91OWsmb_+kMnA@mail.gmail.com>
References: <20140115074308.8471.64824.sendpatchset@w520>
 <20140115083027.GC16455@verge.net.au>
 <CANqRtoQ8sLLXQWKHaxbFpSb+3oBF2Spn_nUZx91OWsmb_+kMnA@mail.gmail.com>
Message-ID: <87txd47od8.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Magnus, Simon

> >> Break out the R-Car SYSC power management code from
> >> the r8a7779 SoC code. With this new shared R-Car SYSC
> >> code base it is possible to hook in Generation 2 SoCs
> >> as well.
> >
> > Is this also useful for the r8a7778 (the other Gen 1 SoC in mainline) ?
> 
> I don't know actually. =) What does Morimoto-san say about this?

Thank you for this patch.
it is useful, but, unfortunately r8a7778 (= M1) doesn't have SYSC


Best regards
---
Kuninori Morimoto
