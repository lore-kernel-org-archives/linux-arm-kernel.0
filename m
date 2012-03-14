From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 14 Mar 2012 15:32:42 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203140958.27289.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203131644.12048.arnd@arndb.de> <4F604400.1040805@st.com>
 <201203140958.27289.arnd@arndb.de>
Message-ID: <4F606CC2.9000402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/14/2012 3:28 PM, Arnd Bergmann wrote:
> No problem, we are all learning things as we are working on them.
> 
> The idea with DT is that you no longer need any board files because all of
> the information in those files is now passed as a data structure to the kernel
> at boot time. Platforms that are fully converted to DT don't have any
> board files but just have one DT_MACHINE_START entry for all of them in
> the common platform files. Since spear600 has very little board specific
> contents at the moment, it is very easy to get to this point now, and
> that will actually help support other boards without having to do more
> patches to add board files.
> 
> When this work is completed, we might actually be able to extend the
> spear6xx DT code to also support spear3xx and spear13xx, renaming it
> to mach-spear. In that case, we would probably need one DT_MACHINE_START
> entry for each family and would not be able to actually build 13xx together
> with the other ones, but I guess a lot of the infrastructure could be shared.
> 
> I would suggest you read Documentation/devicetree/booting-without-of.txt
> to get a better understanding of what this is all about.

You pointed exactly to the doubt i had.
That was very helpful. I really appreciate it.

Thanks a lot.

-- 
viresh
