From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 17:16:01 +0000
Subject: [PATCH V5 13/63] ST SPEAr: Updating Clock Support
In-Reply-To: <b136f1242af026a0453de2c56b88bce55b41e222.1295499394.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<b136f1242af026a0453de2c56b88bce55b41e222.1295499394.git.viresh.kumar@st.com>
Message-ID: <20110219171601.GP29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:55:52PM +0530, Viresh Kumar wrote:
>  arch/arm/mach-spear13xx/clock.c                  |  621 +++++++++++++++++++-
>  arch/arm/mach-spear13xx/include/mach/misc_regs.h |  101 ++--

As I said in the patch system, I think this should be a preparatory
patch before adding spear13xx support.  So I've committed this patch
without the spear13xx changes.  When I commit the spear13xx changes
I'll fold them into that patch.
