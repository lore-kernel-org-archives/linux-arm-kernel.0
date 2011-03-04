From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 4 Mar 2011 15:26:10 +0530
Subject: [PATCH V2 06/13] dw_dmac: Change value of DWC_MAX_COUNT to 4095.
In-Reply-To: <0e767d5a3f538e476b72c7d5ccac88e2f5fcdf1a.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
	<0e767d5a3f538e476b72c7d5ccac88e2f5fcdf1a.1299146382.git.viresh.kumar@st.com>
Message-ID: <4D70B73A.5070105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2011 03:47 PM, Viresh KUMAR wrote:
> - * words, we can do 8192 bytes per descriptor.
> + * words, we can do 16480 bytes per descriptor.
>   *

Sorry this should be 16380. Will resend this patch.

-- 
viresh
