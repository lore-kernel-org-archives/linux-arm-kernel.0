From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Nov 2014 23:31:39 +0100
Subject: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
In-Reply-To: <20141121220503.GJ22670@titan.lakedaemon.net>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141120193804.GA7252@developer>
 <20141121201858.GB22670@titan.lakedaemon.net>
 <20141121225122.1165b466@free-electrons.com>
 <20141121220503.GJ22670@titan.lakedaemon.net>
Message-ID: <20141121233139.3a117e1c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 21 Nov 2014 17:05:03 -0500, Jason Cooper wrote:

> > So the suggestion would be to not document the DT bindings at all,
> > until we reach a "stable" hardware that is distributed externally?
> 
> No, I think it's better to document.  However, we should also document
> the fact that the binding is for an early version of the SoC and subject
> to incompatible change once the production version of the SoC is
> released.  ie, an un-stable binding.

Sounds good.

> > I don't mind adjusting how DT bindings are documented for such early
> > SoCs stepping. But I really believe it's important to have a way to
> > handle this situation nicely: we've been asking for years SoC vendors
> > to start upstreaming their code early. Now that they start to do it, we
> > shouldn't complain and instead adapt to this situation :-)
> 
> Does the above proposal meet your expectations?

Absolutely!

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
