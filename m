From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 16:40:20 +0000
Subject: [PATCH V5 15/63] ST SPEAr: Correcting SOC Config base address
	for spear320
In-Reply-To: <cac5d194ea4be06a5a10dcf8059e87426ae1ee9d.1295499394.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<cac5d194ea4be06a5a10dcf8059e87426ae1ee9d.1295499394.git.viresh.kumar@st.com>
Message-ID: <20110219164020.GM29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:55:54PM +0530, Viresh Kumar wrote:
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

This looks to me like another bug fix, and I'm treating it as such.  It
should be submitted separately from this patch set along with other bug
fixes, and clearly labelled as such.

I've also changed the comments on this patch to:

"SPEAr: Correct SOC config base address for spear320

SPEAR320_SOC_CONFIG_BASE was wrong, causing the wrong registers to be
accessed."
