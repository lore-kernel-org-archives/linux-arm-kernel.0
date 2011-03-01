From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 1 Mar 2011 16:30:12 +0530
Subject: [PATCH V5 00/63] Updating SPEAr Support
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <4D6CD1BC.60403@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 12:55 PM, Viresh KUMAR wrote:
> Following set of patches:
> - updates SPEAr3xx, 6xx support
> - Adds support for SPEAr13xx
> - Removes Multiple defconfigs per machine family

Russell,

As suggested, i have broken down this large patchset to several patchsets.
I will be sending them again to list for getting any further review comments.

I have broadly divided these into following patchsets.
- SPEAr3xx & SPEAr6xx Fixes (8)
- SPEAr3xx & SPEAr6xx: Single Image solution (10) and padmux updates (1)
- Adding SPEAr13xx support (10)
- Adding devices support for all spear machines (17)
- Clock Framework & CPU Freq Updates (3)

-- 
viresh
