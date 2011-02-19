From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 14:40:44 +0000
Subject: [PATCH V5 03/63] sp810 Fix: Switch to slow mode before
	sysctl_soft_reset
In-Reply-To: <25134317a9ba259df7189151daddbaf4440774c5.1295499394.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<25134317a9ba259df7189151daddbaf4440774c5.1295499394.git.viresh.kumar@st.com>
Message-ID: <20110219144044.GF29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:55:42PM +0530, Viresh Kumar wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> Before resetting system from system controller, switching to slow
> mode is required.

This comment could do with some expansion about why it is required.
Eg, this comment could become:

"sp810: switch to slow mode before reset

In sysctl_soft_reset(), switch to slow mode before resetting the system
via the system controller.  This is required by the SPEAr reference
manual."
