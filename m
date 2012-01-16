From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Jan 2012 17:14:55 +0530
Subject: [PATCH 7/8] dmaengine/dw_dmac: Unmap all memory buffers after
 completion of slave transfers
In-Reply-To: <20120116105448.GT1068@n2100.arm.linux.org.uk>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5e5d0fcff79b9b78e64c7424317d6b77736eca43.1326707233.git.viresh.kumar@st.com>
 <20120116105448.GT1068@n2100.arm.linux.org.uk>
Message-ID: <4F140DB7.3060300@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/16/2012 4:24 PM, Russell King - ARM Linux wrote:
> Note that DMA engine drivers are not responsible for unmapping the buffers
> when the transfer completes - that is the responsibility of the caller.
> 
> The automatic buffer unmapping is required for the async_tx APIs and
> offload APIs.

In dw_dmac, it is only done for slave transfers. Is this Okay ??

-- 
viresh
