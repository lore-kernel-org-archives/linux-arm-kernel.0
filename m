From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 22 Feb 2013 08:28:40 +0000
Subject: [PATCH XEN] xen: event channel arrays are xen_ulong_t and not
 unsigned long
In-Reply-To: <5127366502000078000C0380@nat28.tlf.novell.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361285363-27133-1-git-send-email-ian.campbell@citrix.com>
 <1361466961.26546.85.camel@zakaz.uk.xensource.com>
 <5127366502000078000C0380@nat28.tlf.novell.com>
Message-ID: <1361521720.26546.93.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-22 at 08:12 +0000, Jan Beulich wrote:
> >>> On 21.02.13 at 18:16, Ian Campbell <Ian.Campbell@citrix.com> wrote:
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
> I don't see any problem with it.

I'll take this as an Acked-by if that's ok with you.

Ian.
