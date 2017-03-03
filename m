From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 3 Mar 2017 09:03:25 +0100
Subject: [PATCH 3/4] watchodg: sama5d4: simplify probe
In-Reply-To: <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
Message-ID: <20170303090325.41b9ce64@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu,  2 Mar 2017 18:31:13 +0100, Alexandre Belloni wrote:

> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);

Any reason to use irq_of_parse_and_map() over the more conventional
platform_get_irq() ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
