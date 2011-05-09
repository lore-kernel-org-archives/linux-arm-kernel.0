From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 9 May 2011 11:15:11 +0530
Subject: [PATCH V4 1/5] dmaengine/dw_dmac: don't call callback routine
	in case dmaengine_terminate_all() is called
In-Reply-To: <1304917371.32447.10.camel@vkoul-udesk3>
References: <cover.1304596524.git.viresh.kumar@st.com>	
	<8d1b15be425a70cdbd30725b88bd303cc74e706d.1304596524.git.viresh.kumar@st.com>
	<1304917371.32447.10.camel@vkoul-udesk3>
Message-ID: <4DC77F67.80400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2011 10:32 AM, Koul, Vinod wrote:
> How about changing this to:
> 	if (callback_required && callback)
> 		callback(param)
> This will make it look cleaner ...

Sure. Will resend.

-- 
viresh
