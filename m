From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 19 Oct 2010 14:48:03 -0700
Subject: [PATCH V2 45/69] ST SPEAr: PCIE gadget suppport
In-Reply-To: <4CBD33B8.5030105@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<c91308e26397dbe49f384c7d3cf168593e1fe8b0.1285933332.git.viresh.kumar@st.com>
	<4CBD33B8.5030105@st.com>
Message-ID: <20101019144803.96d59689.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Oct 2010 11:29:20 +0530
viresh kumar <viresh.kumar@st.com> wrote:

> On 10/01/2010 05:26 PM, Viresh KUMAR wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> > 
> > This is a configurable gadget. can be configured by sysfs interface. Any
> > IP available at PCIE bus can be programmed to be used by host
> > controller.It supoorts both INTX and MSI.
> > By default, gadget is configured for INTX and SYSRAM1 is mapped to BAR0
> > with size 0x1000
> > 
> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> > ---
> >  drivers/misc/Kconfig                 |   10 +
> >  drivers/misc/Makefile                |    1 +
> >  drivers/misc/spear13xx_pcie_gadget.c |  888 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 899 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/misc/spear13xx_pcie_gadget.c
> 
> Andrew,
> 
> Any review comments on this patch??
> 

I looked.

I'd suggest cc'ing the PCI list and maintainer on future versions.
