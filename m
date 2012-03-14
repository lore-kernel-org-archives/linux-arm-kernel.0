From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 14 Mar 2012 12:38:48 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203131644.12048.arnd@arndb.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203131644.12048.arnd@arndb.de>
Message-ID: <4F604400.1040805@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2012 10:14 PM, Arnd Bergmann wrote:
> I think you should add all the code from this file to spear6xx.c instead
> of adding a new file. We can then delete the spear600.c and spear600_evb.c
> files once the DT support has matured.

But what if have another board in future, and this is what Stefan is going
to do soon, as they have another board.

So we may actually move this code to spear600_evb.c instead.

Sorry for any bad suggestions, i am new to DT. :)

-- 
viresh
