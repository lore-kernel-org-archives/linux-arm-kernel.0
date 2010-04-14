From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Apr 2010 11:36:27 +0100
Subject: [PATCH V2 Resend 05/12] ST SPEAr: Added clock framework for
	SPEAr platform and machines
In-Reply-To: <1269506455-15173-6-git-send-email-viresh.kumar@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-2-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-3-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-4-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-5-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-6-git-send-email-viresh.kumar@st.com>
Message-ID: <20100414103627.GA28940@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 02:10:48PM +0530, Viresh KUMAR wrote:
> Clock framework for SPEAr is based upon clkdev framework for ARM
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear3xx/clock.c               |  389 +++++++++++++++++++++
>  arch/arm/mach-spear3xx/include/mach/clkdev.h |   19 +
>  arch/arm/mach-spear6xx/clock.c               |  483 ++++++++++++++++++++++++++
>  arch/arm/mach-spear6xx/include/mach/clkdev.h |   19 +
>  arch/arm/plat-spear/clock.c                  |  435 +++++++++++++++++++++++
>  arch/arm/plat-spear/include/plat/clkdev.h    |   20 +
>  arch/arm/plat-spear/include/plat/clock.h     |  126 +++++++
>  7 files changed, 1491 insertions(+), 0 deletions(-)
>  create mode 100755 arch/arm/mach-spear3xx/clock.c
>  create mode 100644 arch/arm/mach-spear3xx/include/mach/clkdev.h
>  create mode 100755 arch/arm/mach-spear6xx/clock.c
>  create mode 100644 arch/arm/mach-spear6xx/include/mach/clkdev.h
>  create mode 100755 arch/arm/plat-spear/clock.c
>  create mode 100644 arch/arm/plat-spear/include/plat/clkdev.h
>  create mode 100755 arch/arm/plat-spear/include/plat/clock.h

Please ensure that source files do not have the 'executable' bits set.
