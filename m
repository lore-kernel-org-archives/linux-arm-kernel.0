From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 29 Nov 2010 09:51:54 +0530
Subject: [PATCH V2 28/69] ST SPEAr: Adding machine support for nand
In-Reply-To: <4CF1F650.8080505@windriver.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<1076320a0194c19ef0b4beefdf3c43a44e200439.1285933331.git.viresh.kumar@st.com>
	<4CF1F650.8080505@windriver.com>
Message-ID: <4CF32A62.4030205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2010 11:57 AM, stanley.miao wrote:
> Hi, Viresh,
> 
> It looked you missed the file include/mtd/fsmc.h in this patch.
> 
> Stanley.

Hi Stanley,

I sent this patchset after linus walleij has submitted patchset for fsmc.
In that patchset fsmc.h was at include/mtd/fsmc.h, but later it was placed
at include/linux/mtd/fsmc.h.

I am waiting for few of our drivers to be pushed in mainline, then i will
send final V3 version for this patchset.

-- 
viresh
