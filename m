From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 16:40:55 +0100
Subject: [PATCH 72/74] SPEAr13xx: Replace defconfigs with single unfied
	defconfig
In-Reply-To: <24d22c52ef8367bd6167f2a511cd86176ab6948e.1283161024.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<24d22c52ef8367bd6167f2a511cd86176ab6948e.1283161024.git.viresh.kumar@st.com>
Message-ID: <20100902154055.GP26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:09:35PM +0530, Viresh KUMAR wrote:
> We only need one defconfig for SPEAr13xx now since we can build all
> boards into one kernel.

All this kind of thing should be rolled into previous patches.

We really don't need to know that you developed SPEAr13xx support
such that it initially couldn't build all boards into a kernel,
what the changes were to achieve a kernel for everything, and that
there were several defconfigs in existence before one grand unified
one was possible.
