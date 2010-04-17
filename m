From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Sat, 17 Apr 2010 15:26:13 +0530
Subject: Query: ARM Cortex A9: Is invalidating L1 data cache mandatory before
	usage
Message-ID: <4BC985BD.8040704@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am trying to port Linux on ARM Cortex A9 based platform and what
I see is that if I don't invalidate the data cache before enabling
and using it (in arch/arm/boot/compressed/head.S) the system crashes.

I need to do the same for second core before calling secondary_startup.

Is it normal? Why then other platforms (cortex A9 based) are not doing
this. What am I missing?

thanks for your help.

regards
Shira
