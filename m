From: rvaswani@codeaurora.org (rvaswani at codeaurora.org)
Date: Thu, 26 Jul 2012 12:18:41 -0700 (PDT)
Subject: [DT] API to determine if interrupt is PPI or SPI ?
Message-ID: <53a41d02c4c4c24bdab47667183891bf.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We can specify the interrupt information in the device tree using the arm
gic convention.
Is there an API to read directly the 1st cell and determine if an
interrupt is a PPI or a SPI ? This information is directly relevant to the
driver because it needs to call request_irq or request_percpu_irq based on
this data.

How should this be done ideally ?

Thanks,
Rohit

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
--
