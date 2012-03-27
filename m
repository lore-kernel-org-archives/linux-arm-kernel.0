From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 27 Mar 2012 17:15:37 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <4F71A42C.3090108@st.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203221420.10127.arnd@arndb.de> <4F71961E.2080208@st.com>
 <201203271115.07805.arnd@arndb.de> <4F71A42C.3090108@st.com>
Message-ID: <4F71A861.6090106@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/27/2012 4:57 PM, Viresh Kumar wrote:
> DT should be up but, nodes would be up only once we call
> of_platform_populate() from this init routine.

I was wrong here atleast :(
Can use these routines here before calling populate().

But question regarding multiple DT_MACHINE_START() is still valid.

-- 
viresh
