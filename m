From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 14 Apr 2016 22:18:18 +0200
Subject: [PATCH v2 1/2] dt-bindings: pci: add DT binding for Marvell
 Armada 7K/8K PCIe controller
In-Reply-To: <20160414174046.GA25285@rob-hp-laptop>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1460648177-31473-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160414174046.GA25285@rob-hp-laptop>
Message-ID: <20160414221818.4726e6c4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 14 Apr 2016 12:40:46 -0500, Rob Herring wrote:

> I already acked the last version, did something change?

>From the cover letter:

"""
Changes since v1:

 - Change the DT binding to take only one clock, since in fact all
   PCIe lane clocks are child of the PCIe main clock, so there is no
   need for the PCIe controllers to take a reference to both.

[...]

Rob: due to the change to the DT binding (even though minimal), I have
not kept your Acked-by. So if it still stands despite the DT binding
change, could you send it again? Thanks!
"""

> Acked-by: Rob Herring <rob@kernel.org>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
