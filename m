From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Apr 2011 14:40:07 +0530
Subject: [PATCH V2 7/7] dmaengine/dw_dmac: implement pause and resume
	in dwc_control
In-Reply-To: <20110419085514.GG2820@pulham.picochip.com>
References: <cover.1303194835.git.viresh.kumar@st.com>
	<a1168e413888e35badd9fab6b1626fcfe355dc9b.1303194836.git.viresh.kumar@st.com>
	<20110419085514.GG2820@pulham.picochip.com>
Message-ID: <4DAD516F.50901@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2011 02:25 PM, Jamie Iles wrote:
>From the Synopsys datasheet it looks to me like pausing by clearing the 
> channel enable bit could cause data to be lost.  I think you need to set 
> the CH_SUSP bit and wait for the FIFO_EMPTY flag to go high then disable 
> the channel.

Yes, Previously i looked at some other doc of dwc and couldn't find this info.
But now found it in datasheet. Will correct and resend it.

-- 
viresh
