From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 19 May 2010 12:14:23 +0530
Subject: [PATCH] Watchdog: Adding support for Watchdog found with ARM
	CortexA9
In-Reply-To: <AANLkTinQ34da0F0Xp_Rqh0F8fbh0lbSmD2Q68RLNDlIC@mail.gmail.com>
References: <1274090044-10236-1-git-send-email-viresh.kumar@st.com>	
	<AANLkTil2PtnsKdAHvW5-1WMQyTj6v3uLtrn2CNaZSXkc@mail.gmail.com>	
	<4BF12767.4010402@st.com>	
	<AANLkTikCC108eWniEBwzYsbkEUYQocICaLtd7FD_vMQ1@mail.gmail.com>	
	<20100518132050.GA8748@mvista.com> <4BF362F1.5070100@st.com>
	<AANLkTinQ34da0F0Xp_Rqh0F8fbh0lbSmD2Q68RLNDlIC@mail.gmail.com>
Message-ID: <4BF388C7.8070009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/19/2010 10:47 AM, srinidhi kasagar wrote:
> Viresh,
> 
> Recently I have sent two patches which are already queued in Russell's
> tracker
> 
> 6125/1      ARM TWD: move TWD registers to common header
> 6126/1      ARM mpcore_wdt: fix build failure and other fixes
> 
> which addresses the following:
> 1) fix build failure
> 2) movement of the MPCore TWD registers.
> 
> And currently, Ux500 machine uses this.
> 
> What I feel is to patch this existing driver if you think it is missing some
> functionality.
> 

Thanks srinidhi, for this info.
We can use existing driver as well. Will send patch with enhancements if required.

viresh.
