From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Mar 2014 13:28:11 -0800
Subject: [PATCHv2 13/14] ARM: OMAP24xx: clock: remove legacy clock data
In-Reply-To: <5316217C.2070906@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-14-git-send-email-t-kristo@ti.com>
 <20140304173200.GA17470@atomide.com> <5316217C.2070906@ti.com>
Message-ID: <20140304212811.GA8705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140304 10:58]:
> On 03/04/2014 07:32 PM, Tony Lindgren wrote:
> >* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> >>This is no longer needed as clock data is provided through DT.
> >
> >Looks like there's a new error even before applying this patch in
> >the series as I'm now getting the following oops on n8x0. So cannot
> >test this patch yet.
> 
> Is this with OMAP2 only boot?

Yeah that's with omap2 only.

Tony
