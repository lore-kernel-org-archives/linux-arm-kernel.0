From: leoy@marvell.com (Leo Yan)
Date: Fri, 13 Sep 2013 10:53:53 +0800
Subject: [Question] Verification For arm64: suspend/resume implementation
Message-ID: <52327E41.1070904@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Lorenzo,

I have applied your ARM64's suspend/resume related patches and can built 
successfully. i want to verify these patches on foundation model 
firstly, so below are my questions:

"Code has been tested on AEM v8 models and a simple CPU idle driver that 
enables a C-state where CPUs are reset when wfi is hit."

1. Can u help share this simple cpu idle driver?
2. On the foundation model, if the core is placed into reset state, then 
if there have interrupt is routed to the core, the core still cannot be 
waken up anymore; because the reset bit cannot be released by h/w. So 
how can let the core return back from the reset state?

-- 
Thx,
Leo Yan
