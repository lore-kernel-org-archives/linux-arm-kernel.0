From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 31 Jan 2012 11:10:43 +0530
Subject: [PATCH V2 08/12] dmaengine/dw_dmac: Unmap all memory buffers
 after completion of slave transfers
In-Reply-To: <1327988176.1527.66.camel@vkoul-udesk3>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <ba53f229f3f594bfe0459b01a9ebb4d9b2c15882.1326876464.git.viresh.kumar@st.com>
 <20120118093620.GC1068@n2100.arm.linux.org.uk> <4F1696E4.9070806@st.com>
 <1327982312.1527.61.camel@vkoul-udesk3> <4F27691A.5010503@st.com>
 <1327986775.1527.63.camel@vkoul-udesk3> <4F2779F5.3000701@st.com>
 <1327988176.1527.66.camel@vkoul-udesk3>
Message-ID: <4F277EDB.2020405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/31/2012 11:06 AM, Vinod Koul wrote:
> its deprecated :)
> You should be using dma_slave_config instead to pass the required
> parameters

Aah, i knew it. Silly question.
I have this in my todo list, will do it as soon as i get some spare time.

-- 
viresh
