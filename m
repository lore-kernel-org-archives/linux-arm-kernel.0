From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 31 Jan 2012 10:49:49 +0530
Subject: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
In-Reply-To: <1327986775.1527.63.camel@vkoul-udesk3>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk> <4F1696E4.9070806@st.com>
 <1327982312.1527.61.camel@vkoul-udesk3> <4F27691A.5010503@st.com>
 <1327986775.1527.63.camel@vkoul-udesk3>
Message-ID: <4F2779F5.3000701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/31/2012 10:42 AM, Vinod Koul wrote:
> Btw, can you also fix the driver not to use chan->private?

Ya sure, but i am not in sync with the issue. :(
Why do we need to remove code dependency on chan->private, something
dmaengine specific has changed?

-- 
viresh
