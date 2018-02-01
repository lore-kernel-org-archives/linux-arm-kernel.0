From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Feb 2018 17:52:57 +0530
Subject: [PATCH v6 02/41] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <ff3a0549-2f76-9a8d-21bc-164649e8a6be@ti.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-3-git-send-email-david@lechnology.com>
 <ff3a0549-2f76-9a8d-21bc-164649e8a6be@ti.com>
Message-ID: <2a833d5c-4cd7-5c55-4b4a-a02bd7fde6d9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 February 2018 01:31 PM, Sekhar Nori wrote:
> One thing missing is DIV4.5 clock. It will be nice to add that too,
> mostly just because it will make the binding complete.

Ah, ignore this comment please. I noticed that its part of cfgchip
clocks (which makes sense).

Thanks,
Sekhar
