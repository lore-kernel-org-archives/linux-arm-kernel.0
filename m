From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 29 Jan 2015 15:57:04 +0000 (UTC)
Subject: [PATCH] arm64: Kconfig: clean up two no-op Kconfig options from
 CONFIG_ARCH_TEGRA*
In-Reply-To: <1422525047.26924.3.camel@x220>
References: <alpine.DEB.2.02.1501290928230.19947@utopia.booyaka.com>
 <1422525047.26924.3.camel@x220>
Message-ID: <alpine.DEB.2.02.1501291556280.16475@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Jan 2015, Paul Bolle wrote:

> On Thu, 2015-01-29 at 09:35 +0000, Paul Walmsley wrote:
> > Paul Bolle pointed out that commit
> > d035fdfa27ac124bc8f94c3d7dc82ad069802170 ("arm64: Add Tegra132
> > support") included two Kconfig symbols that are now no-ops:
> > USB_ARCH_HAS_EHCI and HAVE_SMP.  So, drop the two symbols.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Paul Walmsley <pwalmsley@nvidia.com>
> > Cc: Allen Martin <amartin@nvidia.com>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Paul Bolle <pebolle@tiscali.it>
> 
> There's probably no one using that address. But if there is that person
> will be wondering what on earth that message is all about:
>     s/.it/.nl/

Sorry about that, Paul - I noticed the bounce this morning.  v2 has 
been sent with a corrected E-mail address.


- Paul
