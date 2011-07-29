From: vinod.koul@intel.com (Koul, Vinod)
Date: Fri, 29 Jul 2011 17:28:32 +0530
Subject: [PATCH 00/18] dmaengine/amba-pl08x updates
In-Reply-To: <cover.1311936523.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
Message-ID: <1311940712.1536.523.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-07-29 at 16:19 +0530, Viresh Kumar wrote:
> Hi Linus,
> 
> This patchset contains patches for ARM's pl08x DMA controller driver.
> Main changes introduced by this patchset are:
> - Formatting fixes
> - Logical Fixes
> - Support for Peripheral as flow controller
> - Support for sg_len to be greater than 1 for slave transfers
> - Schedule tasklet for error interrupts
> - remove pl08x_pre_boundary() routine
> - etc
Viresh,

There were some fixes required in your driver for changing submit and
issue_pending behavior, was it this one?

-- 
~Vinod
