From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 31 Jan 2011 10:00:57 +0530
Subject: [PATCH V5 00/63] Updating SPEAr Support
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <4D463B01.4050004@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 12:55 PM, Viresh KUMAR wrote:
> Following set of patches:
> - updates SPEAr3xx, 6xx support
> - Adds support for SPEAr13xx
> - Removes Multiple defconfigs per machine family
> 
> Changes since V4:
> - Following patch is added
>   SPEAr: Defining IOMEM(x) and updating declaration of MISC_BASE
> - variables referring to register now have type void __iomem *, instead of u32 *
> - using linux/gpio.h instead of mach/gpio.h in *evb files.
> - return value of clk_get(), and clk_get_sys are checked using IS_ERR().
> - unused routines removed from headsmp.S
> - spear13*_pcie_port_is_host routines are declared static
> - platsmp.c updated according to review comments.
> - Added clk_round_rate routine() and used it to check possible rate before
>   calling cpufreq_notify_transition in cpufreq.c
> - & removed before function names, while passing function pointer to other
>   routines.
> 

Russell,

Should I push these patches to tracker now ?

--
Viresh
