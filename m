From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Mar 2011 22:32:10 +0000
Subject: [PATCH V6 7/8] ST SPEAr: Remove unused *_SIZE macros from
	spear*.h files
In-Reply-To: <92b2423158317c4fc283ae07edfe6047fedea5cf.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
	<92b2423158317c4fc283ae07edfe6047fedea5cf.1298977691.git.viresh.kumar@st.com>
Message-ID: <20110308223210.GA605@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 04:56:13PM +0530, Viresh Kumar wrote:
> Now we used standard SZ_* macros instead of self defined *_SIZE macros. This
> patch removes all such unused *_SIZE macros for spear3xx & 6xx.

This doesn't appear to apply to spear320.h:

error: patch failed: arch/arm/mach-spear3xx/include/mach/spear320.h:17
error: arch/arm/mach-spear3xx/include/mach/spear320.h: patch does not apply
