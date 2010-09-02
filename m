From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 11:07:05 +0100
Subject: [PATCH 40/74] ST SPEAr 13xx : Adding support for SPEAr1310
In-Reply-To: <ac3dec2c43f98984b67c85418e1d39cadc82c550.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<ac3dec2c43f98984b67c85418e1d39cadc82c550.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902100705.GN26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:09:04PM +0530, Viresh KUMAR wrote:
> From: Bhupesh Sharma <bhupesh.sharma@st.com>
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/Makefile                                |    1 +
>  arch/arm/configs/spear1310-smp_defconfig         |  875 ++++++++++++++++++++++

NAK.  No new large defconfigs.
