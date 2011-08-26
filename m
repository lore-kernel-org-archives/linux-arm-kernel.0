From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 26 Aug 2011 14:21:01 +0530
Subject: [PATCH 16/18] dmaengine/amba-pl08x: Add support for sg len greater
	than one for slave transfers
In-Reply-To: <CACRpkdapSvW=eMSoXTOOA2GyhfBLzq2OuyQcDctPxsnVzvr-4g@mail.gmail.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5d691ab0c4f447c9f324213d8d740ac61d1739a1.1311936524.git.viresh.kumar@st.com>
	<20110814083618.GE4986@n2100.arm.linux.org.uk>	<4E4CCF7B.8060704@st.com>
	<20110821083306.GA12028@n2100.arm.linux.org.uk>	<4E532B19.6000103@st.com>
	<4E5715CE.2070806@st.com>
	<CACRpkdapSvW=eMSoXTOOA2GyhfBLzq2OuyQcDctPxsnVzvr-4g@mail.gmail.com>
Message-ID: <4E575E75.40603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/26/2011 1:33 PM, Linus Walleij wrote:
> Patches are individual for that very reason - so they can be applied one by one.
> 
> I already suggested to Vinod to merge the other patches as far as possible,
> for certain 1 thru 15 could be merged right off with some minor
> manual fixup. Then we can fix this one patch.

Actually, Vinod has already applied earlier 17 patches. Now only 3 are left, this one
and two after it.

I just wanted to know, whether i need to do any other modification in this patch or not?

-- 
viresh
