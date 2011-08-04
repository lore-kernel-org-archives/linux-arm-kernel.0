From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 04 Aug 2011 14:23:40 +0530
Subject: [PATCH V2 07/20] dmaengine/amba-pl08x: Changing few prints to
	dev_dbg from dev_info
In-Reply-To: <4E3A659A.6080107@st.com>
References: <cover.1312190881.git.viresh.kumar@st.com>
	<5752f0202ff197d548999395d68131053693e4b3.1312190881.git.viresh.kumar@st.com>
	<1312446527.1539.2.camel@vkoul-udesk3>  <4E3A659A.6080107@st.com>
Message-ID: <1312448020.1539.25.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-04 at 14:55 +0530, viresh kumar wrote:
> On 08/04/2011 01:58 PM, Koul, Vinod wrote:
> >> > +		dev_dbg(&adev->dev,
> >> >  			 "physical channel %d is %s\n", i,
> >> >  			 pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
> >> >  	}
> > ahh, this looks ugly, can you pls fix the print to make them look
> > better. Single line or fmt string is one line should be ok, arg can be
> > moved to second.
> 
> Just to check if I understood your suggestion correctly, you want this:
> 
> 		dev_dbg(&adev->dev, "physical channel %d is %s\n",
> 			i, pl08x_phy_channel_busy(ch) ? "BUSY" : "FREE");
> 
> Surely that will be done.
> 

Much better :)
-- 
~Vinod
