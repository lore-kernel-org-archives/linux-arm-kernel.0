From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 14 Jun 2010 11:16:18 +0530
Subject: [PATCH 2/5] SPEAR3xx: Rename register/irq defines to remove naming
	conflicts
In-Reply-To: <4C15BFDC.70809@bluewatersys.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<1275717955-14545-3-git-send-email-ryan@bluewatersys.com>
	<4C15BB99.4060108@st.com> <4C15BFDC.70809@bluewatersys.com>
Message-ID: <4C15C22A.7070408@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2010 11:06 AM, Ryan Mallon wrote:
> The goal of the patch series is to allow all a single kernel to have
> support for all of the spear platforms, ie CONFIG_MACH_SPEAR300,
> CONFIG_MACH_SPEAR310 and CONFIG_MACH_SPEAR320 can all be set.
> 
> The current code has duplicate defines in
> arch/arm/mach-spear3xx/include/mach/spear3[012]0.h which means that
> these three files cannot be included at once (they are included from
> arch/arm/mach-spear3xx/include/mach/spear.h).

I understood what you did, but i am not sure how will it actually work.
I tried to look into kernel source but couldn't find much.

Suppose all three machines/boards are selected and we got one kernel.
Then how should we tell the kernel which machines init routine to be called.
I suppose through uboot only, but not sure how it internally works.

Can you please help me understand that?

viresh.
