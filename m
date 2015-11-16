From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 16 Nov 2015 16:53:27 -0500
Subject: [RFC] User space to kernel space copy optimization
Message-ID: <564A5057.9080203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the things I'm interested in is to use a memcpy capable DMA
engine HW to optimize user space and kernel space parameter copying.

Of course, this will not be viable for all parameter sizes but I can see
this being useful. The goal is to save power in the cost of little
performance.

Before I go and invent my own mechanism, I'd like to have ideas on what
an acceptable solution would look like. Especially, I'm looking for a
generic implementation that could plug into any DMA engine HW.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
