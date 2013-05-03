From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 3 May 2013 09:26:45 +0100
Subject: [Xen-devel] [PATCH 2/3] xen: move do_stolen_accounting to
 drivers/xen/time.c
In-Reply-To: <5182B532.10607@codeaurora.org>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <5182B532.10607@codeaurora.org>
Message-ID: <1367569605.28742.28.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-05-02 at 19:49 +0100, Christopher Covington wrote:
> Hi Stefano,
> 
> On 05/01/2013 03:27 PM, Stefano Stabellini wrote:
> > Move do_stolen_accounting, xen_vcpu_stolen and related functions and
> > static variables to common code (drivers/xen/time.c).
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/x86/xen/time.c   |  127 +-------------------------------------------
> 
> In going through some of the code, it looked like there might be a few little
> bits that you might be interested in pulling out of arch/ia64/xen/time.c as well.

ia64 in the hypervisor was deprecated and with the 4.3 release has been
removed.

AFAIK ia64/Xen support has been broken in the mainline kernel for year.

Ian
