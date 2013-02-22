From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 22 Feb 2013 08:28:34 +0000
Subject: [PATCH XEN] xen: event channel arrays are xen_ulong_t and not
 unsigned long
In-Reply-To: <CD4C1B4B.4C72B%keir.xen@gmail.com>
References: <CD4C1B4B.4C72B%keir.xen@gmail.com>
Message-ID: <1361521714.26546.91.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-21 at 18:43 +0000, Keir Fraser wrote:
> On 21/02/2013 17:16, "Ian Campbell" <Ian.Campbell@citrix.com> wrote:
> 
> > On Tue, 2013-02-19 at 14:49 +0000, Ian Campbell wrote:
> >> On ARM we want these to be the same size on 32- and 64-bit.
> >> 
> >> This is an ABI change on ARM. X86 does not change.
> >> 
> >> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> >> Cc: Jan Beulich <JBeulich@suse.com>
> >> Cc: Keir (Xen.org) <keir@xen.org>
> > 
> > Are you guys (un)happy with this change from the Xen & x86 side?
> 
> Fine by me.

I'm going to take that as an Acked-by then, assuming that's ok with you.
I suppose Fine-by: Keir would do too ;-)

Ian.
