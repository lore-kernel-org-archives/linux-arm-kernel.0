From: drjones@redhat.com (Andrew Jones)
Date: Sat, 25 Nov 2017 18:40:18 +0100
Subject: [RFC] KVM API extensions for SVE
In-Reply-To: <20171124144538.GG28855@cbox>
References: <20171121134913.GI22781@e103592.cambridge.arm.com>
 <20171122195230.GT28855@cbox>
 <20171123184050.GM22781@e103592.cambridge.arm.com>
 <20171124144538.GG28855@cbox>
Message-ID: <20171125174018.vzu2qsiql2einnpu@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 03:45:38PM +0100, Christoffer Dall wrote:
> On Thu, Nov 23, 2017 at 06:40:50PM +0000, Dave Martin wrote:
> > 
> > I don't think it's all that bad, but there doesn't seem to be any
> > example of an optional architecture feature for a guest today --
> > so I wanted to check before setting a precedent here.
> 
> We don't enable the GIC unless userspace asks for it, same with the
> PMU...
>

And this reminds me that we need to apply the new ID register
trapping support Dave added to hiding the PMU when userspace
doesn't enable it. Patch coming in a couple seconds...

drew
