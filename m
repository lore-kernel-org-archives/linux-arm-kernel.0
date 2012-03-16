From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 16 Mar 2012 09:32:18 +0530
Subject: [PATCH v3] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <201203151140.27453.arnd@arndb.de>
References: <1331808632-22585-1-git-send-email-sr@denx.de>
 <4F61CC81.1020902@st.com> <201203151140.27453.arnd@arndb.de>
Message-ID: <4F62BB4A.9090708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2012 5:10 PM, Arnd Bergmann wrote:
> I don't have the data sheet, so the bus hierarchy above is completely made up,
> but I guess you get the idea. If each bus has its own local register range, it
> may be helpful to use the ranges property to remap the reg properties in the
> way that I did in the apb example above.

Got your point.

@Stefan: You can get this information from clock.c to see which clocks have ahb as parent
and which have apb as parent.

Over that i have kept them in groups/order in the lookup array too. So that would also be
very helpful.

-- 
viresh
