From: horms@verge.net.au (Simon Horman)
Date: Thu, 29 Aug 2013 13:34:28 +0900
Subject: [PATCH v2 00/03] ARM: shmobile: r8a7790 APMU SMP support
In-Reply-To: <CANqRtoTq=w-dsK-fkfWTO+B+VoOMRkuFjCpY=+5qjBZGxDxd+Q@mail.gmail.com>
References: <20130828232148.7321.45739.sendpatchset@w520>
 <20130829001834.GD10207@verge.net.au>
 <CANqRtoTq=w-dsK-fkfWTO+B+VoOMRkuFjCpY=+5qjBZGxDxd+Q@mail.gmail.com>
Message-ID: <20130829043424.GA20593@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 01:11:37PM +0900, Magnus Damm wrote:
> On Thu, Aug 29, 2013 at 9:18 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Aug 29, 2013 at 08:21:48AM +0900, Magnus Damm wrote:
> >> ARM: shmobile: r8a7790 APMU SMP support
> >>
> >> [PATCH v2 01/03] ARM: shmobile: Shared APMU SMP support code without DT
> >> [PATCH v2 02/03] ARM: shmobile: Add r8a7790 SMP support using APMU code
> >> [PATCH v2 03/03] ARM: shmobile: Add r8a7790 CA15 CPU cores
> >>
> >> This series adds SMP support to r8a7790 using the included APMU code.
> >> The previous version of r8a7790 support depended on the APMU code in
> >> "[PATCH] ARM: shmobile: Shared APMU SMP support code", but in this
> >> version the APMU code has been reworked to not use DT. In the future
> >> r8a73a4 and other SoCs may make use of the APMU as well, but the
> >> r8a73a4 code first needs to be adjusted to work with the CCI driver.
> >>
> >> With these patches applied r8a7790 CA15 support for SMP boot
> >> and CPU Hotplug is known to be working.
> >>
> >> Thanks to Sudeep for his feedback.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >
> > Hi Magnus,
> >
> > can I clarify that these patches are targeted at mainline?
> 
> Hi Simon, yes, that's correct. It's possible to back port too if needed.

Thanks for the clarification.

> Actual merge is not rushing though, so please don't interpret this as
> any last minute v3.12 merge attempt.

No problem, I didn't interpret it that way.
