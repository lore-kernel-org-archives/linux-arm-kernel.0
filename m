From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 26 Feb 2014 14:21:47 -0800
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CABGGisxHOVqLcG7hVAuAzdeic41KWSLLBSjQLSJQcjTXLhNCow@mail.gmail.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <20140226200537.GC16149@cbox> <6873065.LH15I057sX@wuerfel>
 <CABGGisxHOVqLcG7hVAuAzdeic41KWSLLBSjQLSJQcjTXLhNCow@mail.gmail.com>
Message-ID: <20140226222147.GE16149@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 03:56:02PM -0600, Rob Herring wrote:
> On Wed, Feb 26, 2014 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 26 February 2014 12:05:37 Christoffer Dall wrote:
> >> On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
> >> > On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
> >>
> >> The most common response I've been getting so far is that people
> >> generally want their VMs to look close to the real thing, but not sure
> >> how valid an argument that is.
> >>
> >> Some people feel strongly about this and seem to think that ARMv8
> >> kernels will only work with ACPI in the future...
> >
> > That is certainly a misconception that has caused a lot of trouble.
> > We will certainly keep supporting FDT boot in ARMv8 indefinitely,
> > and I expect that most systems will not use ACPI at all.
> 
> Furthermore, even enterprise distro kernels will boot DT based kernels
> assuming the h/w support is mainlined despite statements to the
> contrary. It is a requirement in mainline kernels that DT and ACPI
> support to coexist. Distros are not going to go out of their way to
> undo/break that. And since the boot interface is DT, you can't simply
> turn off DT. :)
> 

Personally I'm all for simplicity so I don't want to push any agenda for
ACPI in VMs.

Note that the spec does not mandate the use of ACPI, it just tells you
how to do it if you wish to.

But, we can change the spec to require full FDT description of the
system, unless of course some of the ACPI-in-VM supporters manage to
convince the rest.

-Christoffer
