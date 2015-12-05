From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 5 Dec 2015 13:40:31 +0530
Subject: [RFC] User space to kernel space copy optimization
In-Reply-To: <564A5057.9080203@codeaurora.org>
References: <564A5057.9080203@codeaurora.org>
Message-ID: <20151205081030.GM1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 04:53:27PM -0500, Sinan Kaya wrote:
> One of the things I'm interested in is to use a memcpy capable DMA
> engine HW to optimize user space and kernel space parameter copying.
> 
> Of course, this will not be viable for all parameter sizes but I can see
> this being useful. The goal is to save power in the cost of little
> performance.
> 
> Before I go and invent my own mechanism, I'd like to have ideas on what
> an acceptable solution would look like. Especially, I'm looking for a
> generic implementation that could plug into any DMA engine HW.

Do you have a proposal on how this generic solution should look like, broad
contours of the design to start off with and we can start from that point

-- 
~Vinod
