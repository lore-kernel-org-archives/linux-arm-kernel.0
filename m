From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 11 Aug 2017 10:56:58 -0500
Subject: [PATCH] PCI: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
References: <20170718214339.7774-41-robh@kernel.org>
 <20170802223928.GQ20308@bhelgaas-glaptop.roam.corp.google.com>
 <CAL_JsqLznQdnWw+A2T8V8CTktYaPDF_800jGHAVa=G-Yhxyn+Q@mail.gmail.com>
Message-ID: <20170811155658.GA17039@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Tyrel]

On Wed, Aug 09, 2017 at 05:04:43PM -0500, Rob Herring wrote:
> On Wed, Aug 2, 2017 at 5:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 18, 2017 at 04:43:21PM -0500, Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Thierry Reding <thierry.reding@gmail.com>
> >> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> Cc: Paul Mackerras <paulus@samba.org>
> >> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> Cc: linux-pci at vger.kernel.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-tegra at vger.kernel.org
> >> Cc: linuxppc-dev at lists.ozlabs.org
> >
> > Applied to pci/misc for v4.14, thanks!
> 
> This hasn't shown up in -next.

Thanks, it should be in next-20170811.

I updated it to add Tyrel's reviewed-by, but that's not in -next yet.
