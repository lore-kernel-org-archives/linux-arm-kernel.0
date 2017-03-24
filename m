From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 24 Mar 2017 19:25:09 +0100
Subject: [PATCH 01/15] ARM: dts: alpine: fix PCIe node name
In-Reply-To: <CAK8P3a2WOeNrz3J8vO+n+rhwn3N_vdOswZ0NMmYrdNvmkD8obQ@mail.gmail.com>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322080137.st3osq5ckfis6uwz@kwain>
 <CAK8P3a2WOeNrz3J8vO+n+rhwn3N_vdOswZ0NMmYrdNvmkD8obQ@mail.gmail.com>
Message-ID: <20170324182509.2wwyy5ihwkhvbuu5@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Mar 24, 2017 at 06:00:30PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 22, 2017 at 9:01 AM, Antoine Tenart
> <antoine.tenart@free-electrons.com> wrote:
> > On Tue, Mar 21, 2017 at 09:02:59PM -0500, Rob Herring wrote:
> >> PCIe bridges should have a node name of 'pcie'.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> >
> > This can go through arm-soc directly. If not I'll take it.
> > Thanks!
> 
> I have a mild preference for this kind of patch to get picked up by
> platform maintainers.

Sure. Applied to alpine/dt.
Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/0e5f665a/attachment.sig>
