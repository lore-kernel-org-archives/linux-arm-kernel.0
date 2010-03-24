From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 24 Mar 2010 12:39:19 +0100
Subject: [PATCH] Samsung SoCs: CPU detection support (v4)
In-Reply-To: <20100324070943.GA6779@july>
References: <20100324070943.GA6779@july>
Message-ID: <f333d3ab46b3a4d82c3406199326fc81@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 24 Mar 2010 16:09:43 +0900, Kyungmin Park <kmpark@infradead.org>
wrote:
> Store the CPU ID to cpu_id variable and use it to detect CPU
> 
> On S3C64XX, Some pheripherals such as OneNAND have different
configuration
> and handle it differently to do this it needs to detect CPU ID.
> 
> Also S5PC1XX is supported.

For the sake of completeness, would you consider adding support for
s5p6440?

        M.
-- 
Who you jivin' with that Cosmik Debris?
