From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 31 Jan 2012 09:25:21 +0530
Subject: [PATCH V2 02/12] dmaengine: Add flow controller information to
 dma_slave_config
In-Reply-To: <1327982082.1527.60.camel@vkoul-udesk3>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
 <1327982082.1527.60.camel@vkoul-udesk3>
Message-ID: <4F276629.7000608@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/31/2012 9:24 AM, Vinod Koul wrote:
>> > + * @device_fc: Flow Controller Settings for ccfg register. Only valid for slave
> ccfg maybe true for your controller, not others...
> 

:(

Will fix the comment.

-- 
viresh
