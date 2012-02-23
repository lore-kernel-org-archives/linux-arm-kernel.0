From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 23 Feb 2012 16:23:11 +0530
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian
 register
In-Reply-To: <20120223095345.GJ22562@n2100.arm.linux.org.uk>
References: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
 <20120223095345.GJ22562@n2100.arm.linux.org.uk>
Message-ID: <4F461A97.1090201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/23/2012 3:23 PM, Russell King - ARM Linux wrote:
> 1. Using the PCI/ISA IO macros for non-PCI/ISA IO purposes is silly

We mistakenly placed it outside #ifdef __io, #endif
Sorry, i am still missing your point.

> 2. We should have readb_be() etc instead.

Actually, existing drivers are using out_be32(), etc in their implementation.
What do you suggest in order to use these drivers for SPEAr/ARM.

-- 
viresh
